Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237600;
	b=2trozRvF0Gww6b+kdJAi8l9hwjqlmHGW/A3WuM2IvslHtd8C5txHqyESowp6KNGPdk83
	 0BUhuhZizuFtTzaQkZfiyLIBa9XZ+GEqTRJ8Dn+h0KiSpIA+LVwcEpQt0dDIinA1fGOrH
	 sZzpV3x+hW+Plw9TRva+z6tNpNva5D6erDWjNzdwpOD/dE0d4yJPNhMiwQjuFrPB0Ff03
	 9UPz0aTu23IIirNgWkHfGgXT9Hx4uuILLRZtztLUP0Iz0fC4bHQHfirdbgO6wPzNtbVwp
	 CjkjcAa+oJT8LXWObdnV5ud+p2n3YislsQj0h6v7xpEAdS6YtSOvOHapm7h9st+6Ykg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237600;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qvqUJi1pItpI83LRxCu4hVk1nrPP0WYemL0+nUGEoTg=;
	b=Kh8HXEwwCTgq0gKX01Yyc8UWRvwQ6oIr++L3DBlkMi1xQfgsaY3Qnkevzg94HA6lt0S3
	 zszHOEkeioDfoDAG/iacvweKhZ8G2sw5wTyhI8k5BH13kQKCKUV9Lr5vMJSmeRsXwvlWR
	 U1qrBfgAteotiO33GAlJBN1FqCApC+QxQYi9SDwcbuFp8KqPAiayt1OsHOU4fdaXutTVI
	 qjJ7nnzzhpa4W9TIgKmScgiJaCN3SNF8HxAuBjysxsiZjaNPk+F4HCLCPvkILFX/ix2My
	 VEWQ6fHfje/fbJgfkUdFnLRkEn7jV93rxHghz9k5RofwqCTu8xFm0tK/S6YYjZBQ2BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMGinqmy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0E606A333;
	Mon,  9 Nov 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMGinqmy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13541F0089F;
	Mon,  9 Nov 2026 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237600;
	bh=qvqUJi1pItpI83LRxCu4hVk1nrPP0WYemL0+nUGEoTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BMGinqmyNNhf2sLE4SZGpI3cb8Pr6q1qNFUmrSxSLaa/W7Bn8+uhWD3vp1CgKS05a
	 N/tO+aJjrGdjlFZHN4HH5hsQEdLWlSH5PqsLPb5rS2cVqTt/EH/aEVkCv6GTZiw+c+
	 xcG6vOpE2SJCWRrzOrXb+OcwmlZt4joJFu0O+lHgpXFB4REAZvYDFkd4zdj6XPr0V9
	 q0QSE3vj+xpm0g2SQheGI49I/yMxz0DbegiNL5t0XpphXYnhAnWrlsqTwm1FRkEE3m
	 wsLTKmmIuyZqYHfE6sTBEtdHAG3Sm3JW0ev6wvm3PKVIskGelF9ylPpMwIpxhuRtLe
	 X7tCPHUeCveTg==
Date: Mon, 9 Nov 2026 16:19:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci_dwc: reject invalid device tree port numbers
Message-ID: <avHknBRJnZPpAIke@ryzen>
References: <20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn>
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
In-Reply-To: <20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn>

On Wed, Nov 04, 2026 at 10:13:18PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ahci_dwc_init_dmacr() reads the "reg" property of every available child
> node and uses it directly as a port number, both to compute the port
> MMIO base and as an index into dpriv->dmacr[], which has AHCI_MAX_PORTS
> entries.  ahci_platform_get_resources(), which runs earlier, checks the
> same property against hpriv->nports and skips invalid child nodes, but
> this second walk does not.
> 
> A device tree that describes one valid port and one port with a "reg"
> value above AHCI_MAX_PORTS therefore makes the driver write past
> dpriv->dmacr[] and access MMIO beyond the mapped region.  Apply the same
> check as the resource loop and skip invalid child nodes with a warning.
> 
> Fixes: 33629d35090f ("ata: ahci: Add DWC AHCI SATA controller support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG arm64 guest, KASAN) with a
> TEST-ONLY device tree.  The DT adds a snps,dwc-ahci node with port@0
> and port@100; the TEST-ONLY printk hook in ahci_dwc_init_dmacr() is
> applied to both kernels.  mem=512M keeps the fake MMIO window outside
> System RAM.
> 
>   unpatched                            patched
>   KASAN: slab-out-of-bounds            no KASAN report
>   in ahci_dwc_probe                    port 100 skipped, boot
> 
> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> index feb8a8539b8e..9094eb19e19f 100644
> --- a/drivers/ata/ahci_dwc.c
> +++ b/drivers/ata/ahci_dwc.c
> @@ -225,6 +225,12 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
>  		if (of_property_read_u32(child, "reg", &port))
>  			return -EINVAL;
>  
> +		if (port >= hpriv->nports) {
> +			dev_warn(&dpriv->pdev->dev,
> +				 "invalid port number %u\n", port);
> +			continue;
> +		}

Again, this warning is reduntant, as it is already printed by
ahci_platform_get_resources().

Perhaps:
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -225,6 +225,10 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
             if (of_property_read_u32(child, "reg", &port))
                     return -EINVAL;

+            /* Already reported by ahci_platform_get_resources() */
+            if (port >= hpriv->nports)
+                    continue;
+
             port_mmio = __ahci_port_base(hpriv, port);


And please send this as a patch 2/2 with the libahci_platform patch as a
patch 1/2.


Kind regards,
Niklas
