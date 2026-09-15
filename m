Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC843CF200
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438806; cv=none; b=RbMcWv1tgSiQS9PmpCM6YzcTANsr6PaTc/b3XuLdIXMKHFq74Dk6zNkXT2lYBT9PuCWODwA0M4fb7vjcm4vjRvLG8iRBvH/UGzRqj8Sh3dH00yacenC6U2BNfIIA+/Rd0Dcp17Z0f7ID+cBWL1uyO3e1SayAwCkMNrWjcmgyv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438806; c=relaxed/simple;
	bh=btHyMjROFbWa/sVZOyhi5qb+H2Bzwtlr5aC1bzCWOkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2Tov7EwekyMCk4oQZEy+JNacBx6H1OZ1H+Q8Q3QUoAoCOjfdTI+faTvvLMgnhnWEOAoisHWnLaeTQTDIPZo7Rjs+VaA2mr8dOrJ1sMjs6jt01f4IPXRXAfmTMvLjAUekx7UjR1237K8EHESZVXyVVBndcMvr8dC4OVYOBABsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JGRdRrTc; arc=none smtp.client-ip=91.218.175.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JGRdRrTc"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=btHyMjROFbWa/sVZOyhi5qb+H2Bzwtlr5aC1bzCWOkk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789438801; v=1; x=1790043601;
 b=JGRdRrTcQQ7C1sv4eU6zIpW4VPfDyVdk9fprU4L7YcZcKqptsA1uwWTcaF9TdEuE4C4Uo7qo
 Xne3QRuNrCqI+J5vRPVe2t9jcJNiUDIq/tu+0SUcBMtKQQa15/fwf1aKaZIBRaW3e088D1VCIaC
 d4vQ9DyEUORo1XFf0nVCUvjk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1f80b086769be0c;
	Tue, 15 Sep 2026 02:19:51 +0000
X-Mizu-Trace-ID: e1f80b086769be0c
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 10:19:43 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: wan: farsync: Disable PCI device on removal
Message-ID: <20260915021943.GB95173@pc>
References: <20260915015941.86661-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915015941.86661-1-mhun512@gmail.com>

On Mon, Sep 14, 2026 at 09:59:40PM -0400, Myeonghun Pak wrote:
> fst_add_one() enables the PCI device and disables it on probe failures,
> but fst_remove_one() never releases the successful probe's enable
> reference. Disable the PCI device after the existing interrupt, tasklet,
> mapping and DMA cleanup has completed.
> 
> This issue is already present in the initial Git import; its pre-Git
> introduction is unknown.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/net/wan/farsync.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
> index 6508c53..0ea6372 100644
> --- a/drivers/net/wan/farsync.c
> +++ b/drivers/net/wan/farsync.c
> @@ -2561,6 +2561,7 @@ fst_remove_one(struct pci_dev *pdev)
>  				  card->tx_dma_handle_card);
>  	}
>  	fst_card_array[card->card_no] = NULL;
> +	pci_disable_device(pdev);
>  	kfree(card);
>  }
>  

The patch looks good to me. By the way, the commit message could be a bit more concise.

Reviewed-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Thanks
