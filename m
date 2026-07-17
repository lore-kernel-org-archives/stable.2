Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349E3F6C26;
	Fri, 17 Jul 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290918; cv=none; b=NiG69QevGcL5sRgrGYf0HgY+Z4v/DQNXYg4HF7QdLalTY4wOOA0B8gFqU3hJVfDFTq8Td3MN2vLJX30KjHyD9J1TY5UmpPjcZsYQ3anPQZEuy0S4GhuJF9YfqjQltrYt0X7YPtHyt/9a2LtD3T0sMMnrpKk2xCd6eRdtS0eeu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290918; c=relaxed/simple;
	bh=whLMtwHeR8oIOg9sm0uROx3C0eqPSagEQ6BP8x7o2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUBEgHtRbQzVauxq4+YNNTSiXKDY1Es/JU0jMQvm+n0TGx/jvVVratZblz+xJ+ra6/tcJznQ+G1Zg52dPMQ6P5k4HP64+fwho1CUp3hMiomHV6hz/fiTVqHB2626lYRWrZDMqraXecBC/xkj32pQwmm9iQQqyY7YVWXL3C2igjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jB5PWGyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jB5PWGyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE91F00A3A;
	Fri, 17 Jul 2026 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784290915;
	bh=gAmTeBmuRfkvTtrAi+vxy6npn3un2/1du1pt12NAkUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jB5PWGyo8T2H5eDzRcQClqPwJ8Ek5PAphzulnAp2tHBmbqCq8DvM962O4W/BPk8wa
	 lpq7UTZQWk4dGDhFcbsc01VoKHYrw1badie43222pmu8JNzt+UBByB7Nvu+q+mTSTT
	 Javash8plTH1pg8XGU5vvoz/LbvQoeaw7nt8n3nA=
Date: Fri, 17 Jul 2026 14:21:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Cc: linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Jes Sorensen <jes.sorensen@gmail.com>,
	Manuel Ebner <manuelebner@mailbox.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing shared-key auth
 challenge length check
Message-ID: <2026071726-crust-capped-9011@gregkh>
References: <20260708104252.144101-1-npetrakopoulos2003@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708104252.144101-1-npetrakopoulos2003@gmail.com>

On Wed, Jul 08, 2026 at 01:42:52PM +0300, Panagiotis Petrakopoulos wrote:
> The WEP shared-key authentication handlers use the challenge-text
> element's length. This text and its length are attacker-controlled.
> The handlers do not check the length against the fixed 128-byte
> chg_txt buffer.
> 
> In OnAuthClient() the length from rtw_get_ie() can be up to 255 bytes.
> It is used to perform memcpy() into the 128-byte pmlmeinfo->chg_txt.
> A malicious AP sending a malformed WLAN_EID_CHALLENGE element can
> overflow/underfill chg_txt by up to 127 bytes. This is reachable over
> the air, before association, during shared-key authentication. In the
> case of an overflow, the driver can write out of bounds. In the case
> of an underfill, the driver can echo stale buffer memory. In OnAuth() 
> a similar issue is observed. The driver compares a full 128 bytes
> regardless of the element's length, reading past a shorter element.
> 
> The challenge text is defined to be exactly 128 octets, which is
> already provided as the WLAN_AUTH_CHALLENGE_LEN define; require the
> element to be exactly that length in both handlers.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
> Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
> v2:
> improved patch description for clarity. no code changes.
> 
> testing:
> Compile-tested only; I do not have RTL8723BS hardware to test the
> shared-key authentication path at runtime. The change only rejects
> challenge elements whose length differs from the spec-mandated 128
> bytes, so conforming peers are unaffected.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index a86d6f97cf02..13634d4e83d1 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -787,7 +787,7 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
>  			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
>  					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
>  
> -			if (!p || ie_len <= 0) {
> +			if (!p || ie_len != WLAN_AUTH_CHALLENGE_LEN) {
>  				status = WLAN_STATUS_CHALLENGE_FAIL;
>  				goto auth_fail;
>  			}
> @@ -873,7 +873,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
>  				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
>  
> -			if (!p)
> +			if (!p || len != WLAN_AUTH_CHALLENGE_LEN)
>  				goto authclnt_fail;
>  
>  			memcpy(pmlmeinfo->chg_txt, p + 2, len);
> -- 
> 2.55.0
> 

This does not apply against my staging-linus branch.  Can you rebase and
resend?

thanks,

greg k-h
