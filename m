Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065329;
	b=yNHsfDB5bXHxaGUzsZtKtHLpouqjmLWaXLfo17yZNsnKvATXAvqqicBSF8IJkdK2/Ro0
	 Rjsb16CKUYL7G68kJormejKZVpSzRpbYNvNuaUis7Sbjs1BsS/xcuVBzRO1aQdm0ta+Dm
	 yYF5ThI/1632+GfPb+99Wi6CzbnRQs/1H3FovXrRjrjgEAZHHAZsi04gucuTJnDPSmZu2
	 qrmVnivP4tmMcO9q834F4nam5OtlFHPts4Q8SA0jNcwxiv4H0r+uLQ1LsRFkKdx/zGcwg
	 wvzppFlc9NEnmJXWgp7Q/P9q9Rnrx8MUlYFYbOF93f0e06nvB/5KMuJOAX8TYJ6j5cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065329;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9d/9KitAZXEBwhLTbhpIMJwSXCsdx2BWGznXvUAvq1Y=;
	b=jvJdNlJ1YAn2uC8rfwMNxvhRB9sCTBW8qBwEMU6HGS3nIgTXSNn5lf443fX/kqA5rTPJ
	 LW4hzSDIZfD9urikAE1eiVuc9mERl2CWGJ6FRqhLedWbq/T++0Do/1FD+DAsRxyeqsjVl
	 JnGQJV22ue2ly6zdNFGxZvNd9rdEc25fXs8Pqb07cl2jGmOZ3VqU1WJDQ1C9Ob9FvuLth
	 rmos7iLZeqkMciIp7KKlOcN0Ifp7TbZpduc6y9OmLbKRsYoKr+XB50rmbXVhZ+DtcWnwA
	 g7msj2wPTN1+Ovn4T8GcnjM3YRUhy+1tYTzwNJQg3S5I7+YPOW1gi7K11KUZtKul3bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B59KN+ov;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C10606A32D;
	Tue, 27 Oct 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B59KN+ov
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005B81F01828;
	Tue, 27 Oct 2026 01:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065329;
	bh=9d/9KitAZXEBwhLTbhpIMJwSXCsdx2BWGznXvUAvq1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B59KN+ovxuBuaYX4aqCHx6CfdlejeF5RHsrqLZDvEnDNrfRFqFSV/bSW3HOa5Itbk
	 6JXU1tWz8GadX4g1dADO/6v4fRgfNgRIVSrbkxcq4Zhxz/TRwoDDuKJXhPENvKSjhT
	 ROFIXKQaM8rgwvCe/4bhBNNqcKbCXIRBw8+USgXKvHicg7/Wn7qtagyaVJhK61IUMn
	 Ip6PFqbARNtTSFyeksfZZGKqLBu1K8/B1jkNPYfm39jYxbUfqdWy6TivV70vTTb3f8
	 0DrtHM3mE/M8SAI64Kt4H0WZOKQ61wFFVRTbWxobDxRDGciBUFLdg0+l0hgT5lg8T0
	 Uqi/SbKUQpWoA==
Subject: Re: [PATCH net v3 3/4] gve: Block invalid ring sizes when device
 options are 0
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com
Date: Tue, 27 Oct 2026 01:42:07 +0000
Message-ID: <179306532757.3134.16501377800126286936@kernel.org>
In-Reply-To: <20261023204706.3112215-4-hramamurthy@google.com>
References: <20261023204706.3112215-4-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In gve_parse_device_option()
  (drivers/net/ethernet/google/gve/gve_adminq.c:194-197), the new…

Pre-existing issues:
- [Low] gve_parse_device_option() (gve_adminq.c:177-197) accepts
  MODIFY_RING options with option_length 9-11, because it rejects only <…

--

gve: Block invalid ring sizes when device options are 0

When the MODIFY_RING device option reports a minimum RX or TX ring size
of 0, this patch makes gve_parse_device_option() fall back to the
driver's default minimum ring sizes. The goal is to stop ethtool -G from
accepting ring sizes small enough to crash gve_tx_alloc_rings_dqo().

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 8b215fca9c1b6..2c848f0c23dc2 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -191,7 +191,9 @@ void gve_parse_device_option(struct gve_priv *priv,
>  		*dev_op_modify_ring = (void *)(option + 1);
>  
>  		/* device has not provided min ring size */
> -		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
> +		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
> +		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
> +		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
>  			priv->device_info.default_min_ring_size = true;

[Severity: Low]
If only one of these two fields is 0, should the other minimum from the
device be kept?

Both directions share the single default_min_ring_size flag. When it is
set, gve_enable_supported_features() replaces both minimums:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_enable_supported_features() {
    ...
		if (info->default_min_ring_size) {
			/* If device hasn't provided minimums, use default minimums */
			info->min_tx_ring_size = GVE_DEFAULT_MIN_TX_RING_SIZE;
			info->min_rx_ring_size = GVE_DEFAULT_MIN_RX_RING_SIZE;
		} else {
    ...
}

Take a device that reports min_rx_ring_size = 1024 and
min_tx_ring_size = 0. Its RX minimum would become
GVE_DEFAULT_MIN_RX_RING_SIZE (512), not 1024. Before this patch, the
non-zero value was used.

gve_set_desc_cnt() copies these values into priv->min_rx_desc_cnt and
priv->min_tx_desc_cnt. Those are the only lower bounds that
gve_validate_req_ring_size() checks:

drivers/net/ethernet/google/gve/gve_ethtool.c:gve_validate_req_ring_size() {
    ...
	if (new_tx_desc_cnt < priv->min_tx_desc_cnt ||
	    new_tx_desc_cnt > priv->max_tx_desc_cnt ||
	    new_rx_desc_cnt < priv->min_rx_desc_cnt ||
    ...
}

Would ethtool -G rx 512 then pass validation and go to the device, even
though it is below the minimum the device reported?

A per-field fallback would use the default only for the field that is 0.
Could that fix the zero-minimum crash and still keep the other limit from
the device? For older devices that report both minimums as 0, as the
commit message describes, the two approaches behave the same.

[Severity: Low]
This is a pre-existing issue, but can these new reads go past the end of
the option payload when option_length is 9, 10 or 11?

The length check earlier in this case rejects only lengths below
GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (8):

drivers/net/ethernet/google/gve/gve_adminq.c:gve_parse_device_option() {
    ...
	case GVE_DEV_OPT_ID_MODIFY_RING:
		if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING) {
    ...
}

min_rx_ring_size and min_tx_ring_size sit at payload offsets 8 and 10,
and sizeof(struct gve_device_option_modify_ring) is 12. With a length of
9 to 11, part of each read comes from the next option header or from
unused descriptor space.

gve_get_next_option() only checks option_length against the
device-provided total_length. Also, total_length is never checked
against the GVE_ADMINQ_BUFFER_SIZE allocation.

If those out-of-option bytes are non-zero, the fallback does not fire
and the bytes are used as the device minimums.

The baseline gve_enable_supported_features() already read the same
fields in this case, because default_min_ring_size stayed false. So this
patch does not add any new reachable impact.

Would checking option_length < sizeof(**dev_op_modify_ring), instead of
comparing with == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE, close this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023204706.3112215-1-hramamurthy%40google.com
