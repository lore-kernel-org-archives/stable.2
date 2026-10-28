Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213025;
	b=AOlm1sirzJ4q6JyBPIrs5QsJ9r5t/qnz1I2TvnCcHVV4oewQH5yoLK8KRzCp+PI3kvx3
	 lNRLn/ixAA0n947AXcbCC9f8wRL3pGC6YnYSKl5wSByUmxVuN1D0LwsEH5kVAXWz9cagZ
	 vHNWWF7tQpG4GecV36j4H1s0kdyqO4YOsc0YFIdS0rw2KQ3MO5mCkE0Opl87Fk2bBo9GR
	 Zclufsq+MPp+B3QwJbX/8ZPTefcs41rQhiyk6nK30U3nbZNV6MIiEt4jk/VGyPVqxMRDx
	 0EX1OWQ85wXGtJQUQwgG/EFCrj3xabAaviGm+RjZeDlQB9GH/yCJ/VnI7Q13E/dxhyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
	b=CCedNe3o+00e5htZpFGVcHIqujBSc/PAnWS2E3viVDABKhypmhhCqUUWcBDlECYrAVHG
	 H9O5EDmMqe6HzqHidWfiXVcZ7BPmtAmFIkHHK0I7/F7rj3RpoCqBMmXlTRbFQPtdkmsxo
	 U1gCArUzAu2GNoZVuzBRX4/0puvGB2vU11fa/V76RnOgMyopzQrMoDCBUOtuZV0eOwD6B
	 yfHoT8D/XYpEcMSYhOOWkRoSM0ndAESkBd/wtLts+o+KCbZcGtqHjeyrFKuJKmBk0y7JJ
	 6J63CiYOOE6Sb7qVH5q8SB8EB8EaOn5jLxgzAkB8vBIbCsr6anJPkmxMW5D7r1OYS4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=o8GJKJZq;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B55606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6B55606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=o8GJKJZq
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E0E2F3FCF0
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793213021;
	bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=o8GJKJZqqiiHIy/XgmHLmXWju7phzlobmGGJ76dsB+Xe3Oh1JjbJLAQs9Bl/M8qVk
	 vTUy/HFq6BaggI12b+0M/+hDbJjQYSs8MMuo+uRXRhRvq+lyEvWb2owLIFCPYcBaxc
	 7tPgLKnoCS08Bh/0qVoAcvpu1klm44NkBv7J9g3ddGLJSeGK7HPA3WlCRAWklakd56
	 ntwJ/azqhfkpu9GrNhnhc66nn858iJEXM5Y/gmbStpRFIb9NPPOStw+p6GKZNlFXkT
	 /JGswiC6t9L8Bky3KHJgMJy44fTsqXzxm+uqyldCzEASwwo/3NiIcdxBYTXtXREDdx
	 y0cyt5BwNJJxhic57tDsLb6M7fC0Sa2HCa1GWvZ3zORby5QBI3/myOhpHUe75LR6H8
	 L0MDhZ9qWHVHCmdmKwhB3MLGVA1K1IVXrcRVYF3pGYyzLQsZOOLot55X1L0qjdKjJl
	 AQ5+ECFrJqXg1Xwy/n3rloCcdA1ZMygIw3V9nSeldHvYRrUYiSunGnkiDxjYrAEBLe
	 BJG8YkMrf04hifNTiDxppYQNRRL/AzWQVizIxd4rC5QzAmUQRi+pwovkGRQvsubjo9
	 C84eYpjY0H7rIE+BfFci72kTSnaF9SraOs4J0UCIZD+6FEG4KEFB5joHO8YIJGZTm+
	 5e6wyyBKoUWq3P/pT4rrOseY=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab27c28489so373812a91.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213020; x=1793817820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
        b=d0s3xD3oghOuXTKuiR0w78r8+ICPhCOIf7xTy9vAIoEs3sDJvo0vsRtcV42abhOC3y
         hn+J9EX6XrZTj5Q6V1o80xyrs3KyvFgZFZHSswPX0mEAVIwWwpV6UcKB6xg630DeSgOJ
         TBeI8D5CeH3JmxARMn/UMzgo+l5Sh0S6Mao/zedhBNxNCdjEbU1yUhQa8g6DtEzUSxr7
         k8U74lX62oC5zoHEocHUEw6XYttmIgiWTWhj7DjYlRAtdEK1XkEjEjn+9oQvD91Rzza6
         t1nMu2zM/ChPE+qmEVucq6vfn2t+TTF8oB9Wpr0sdse4huIem/ToSavfaCG1WLhBTsyB
         29Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxHMGF7yLd3gGcKtbtvztqh2YZ1KXr3N87zmudKGNT4j+SwYZkRnZr+wnnUtaye19kUW9F89IQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNJTPFPjZSBxneMWHWYob7cv16RZWJqj6dKbyY7quqDzuxvgA/
	8+YLdwjhpRUAsT8MHMV1bm+8gMrQnlUNOO0eNjw/KZGSTzK00/6aT4ruHnHDZkt1DVV13/2m99X
	56DqEwmLehWy0qGWzFbMRB4sXWTiqSGyGmIMPYA5fV8tj9IfkYDTpbPEe3aGPYxr8b9Kytzq9mW
	UNn2FO8KKG
X-Gm-Gg: AYBFou1ctMRoMBp+oPRAFNk7xGX/HlZTSvU02tNQNL3eCx3PS0Z1VTKtyL1LIodduIz
	T56HeAUi8zDF8kjcWTXWj8w9q+HWUvyggL/fBovbvBFEvqluWHxkA3xf+oz8ZIdpGG4UX1k648+
	t682+sk5+Axk5h3E0q44aOV3GNIEScBYsZAaBEMnGJb3yax6UKj7U6yDryicc5YtYOppCuBWPw+
	lW0CEWQ1Ub45jfdOuDqIvzAJfQ0pxpTWuI5rMEb5j1BoqVYRUZ8BLvYeZU0VhaUcAZ1YFootgaz
	X+wxS+e2NlLl3ZWMBj2teOHtCsaFgHnrZBCiaT+VIquQsRCU24wmiaYS3X+7vwW5TM8EA1cs+Pp
	Ldkel+O6NpjrGgOBtx2rhnBOVytMIWoBAa66wpPyFDcroWDcfCCmpP/2t3jjGz1s+aFI+9E3hfc
	QCdpfBuqXv2i+kGKFUkUj3w4ytP+W8OP7ooup0TtZxMMrka3jj+Jj4JCMjCESsCDQ1SV3jk4mXZ
	mza0gEi2cFcFtgRsFEZUZXv8pWARv0jodPGHbFjVWvafV/njp1Yp3ySOSi+QarOrE/wHj+fz8s5
X-Received: by 2002:a17:90b:180f:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3ae57eae277mr4429462a91.2.1793213020319;
        Wed, 28 Oct 2026 11:43:40 -0700 (PDT)
X-Received: by 2002:a17:90b:180f:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3ae57eae277mr4429441a91.2.1793213019898;
        Wed, 28 Oct 2026 11:43:39 -0700 (PDT)
Received: from localhost (2001-b011-2008-445c-6e54-18f2-1df8-9655.dynamic-ip6.hinet.net. [2001:b011:2008:445c:6e54:18f2:1df8:9655])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm626696a91.17.2026.10.28.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:43:39 -0700 (PDT)
Date: Thu, 29 Oct 2026 02:43:37 +0800
From: ChunAn Wu <an.wu@canonical.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, kiran.k@intel.com,
	chandrashekar.devegowda@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: guard debug dump before hdev
 setup
Message-ID: <auJAzRIrhM3x1WEW@an-XPS-15-9520>
References: <20261013125241.1230408-1-an.wu@canonical.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013125241.1230408-1-an.wu@canonical.com>

On Tue, Oct 13, 2026 at 08:52:41PM +0800, ChunAn Wu wrote:
> An MSI-X interrupt can reach the debug-dump helper before
> btintel_pcie_setup_hdev() initializes data->hdev. The helper then
> passes NULL to hci_get_drvdata() and crashes the interrupt thread.
> 
> Return early when hdev is not available. This covers the GP1 and GP0
> error paths while leaving interrupt handling unchanged.
> 
> Fixes: 190377500fde ("Bluetooth: btintel_pcie: Dump debug registers on error")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
> Changes in v2:
> - Add the missing Fixes: tag required for the stable CC.
> 
> ---
>  drivers/bluetooth/btintel_pcie.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index ac7193400769..8d7927bd75b6 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -297,12 +297,17 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
>  
>  static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
>  {
> -	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +	struct btintel_pcie_data *data;
>  	u16 cr_hia, cr_tia;
>  	u32 reg, mbox_reg;
>  	struct sk_buff *skb;
>  	u8 buf[80];
>  
> +	if (!hdev)
> +		return;
> +
> +	data = hci_get_drvdata(hdev);
> +
>  	skb = alloc_skb(1024, GFP_ATOMIC);
>  	if (!skb)
>  		return;
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> -- 
> 2.34.1
Hi Maintainers,
Could you kindly help me to review the patch
Many thanks

BR
    An 
