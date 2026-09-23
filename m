Received: from mail.fhannenheim.net (mail.fhannenheim.net [188.245.251.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FE477E37;
	Wed, 23 Sep 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.251.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157053; cv=none; b=GH4kW7eU4+tK8t2hZai5vX2kuIxwS02ehKeervBZaJfJn2hNaixH0Nn37qSGBi+KwfILZZhtLjxsOPUu9o/jCIEevmxMWam8QnD40DuEe57INaqKr8KyuVmNkjhPbnV3oonSHrqY+j/OJ8tHgkt0DCmOezWK4TFQYAm1Xi/XAUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157053; c=relaxed/simple;
	bh=3gJrRsmKPB7eJUuw+VZSGY+71yBpCrpZY9rWwKjvMXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MScpGiQ+xXAaAp75Ajs9A871qQGhwH0DwV0rSVC1CzIUuI0fZu0i6YQyTcyqyKTgWLxP/8dxLMZBbMcXdu0XanryxFzVUstZ8hqlyya5C3IeNum3rlItFZ1C1xmdrzZQESU4f1+QDpBZaMWlFxnky3CpuJ4m9mSO2f8Afad1iZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net; spf=pass smtp.mailfrom=fhannenheim.net; dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b=QypCSh9u; arc=none smtp.client-ip=188.245.251.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fhannenheim.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fhannenheim.net header.i=@fhannenheim.net header.b="QypCSh9u"
Message-ID: <52bbd4c5-795f-4901-8b32-a1700d33b66d@fhannenheim.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhannenheim.net;
	s=mail; t=1790156674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvN63iinQqNBNDu13VGaPnwDGRiYSsSs4VK48OPwTW4=;
	b=QypCSh9u20oVgMy/CkvVdYqwcgh9FDUV87U/8vaj/KsHSvMmS6nhPT8EILKbOs6dS94Bg/
	GTOxpRmIVpkjOZrc3FpuPCpJv7hyVe33RqaeN2LVfuUoKbloPTMeuCGmTYx0LtcSZ9hUTS
	wKwaRrOEMaP1JEDJTxv8MAj6dimkG9U=
Date: Wed, 23 Sep 2026 11:44:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] misc: fastrpc: Don't fail probe when the SDSP memory
 assign fails
To: david@ixit.cz, Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xingjing Deng <micro6947@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
Content-Language: en-US
From: Frieder Hannenheim <git@fhannenheim.net>
In-Reply-To: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.09.26 00:38, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> A failed qcom_scm_assign_mem() aborts fastrpc_rpmsg_probe(). On SDM845 this
> turns every SLPI subsystem restart into an endless probe failure loop:
> 
>   remoteproc3: crash detected in slpi: type fatal error
>   remoteproc3: remote processor slpi is now up
>   qcom_scm firmware:scm: Assign memory protection call failed -22
>   qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: probe with driver qcom,fastrpc failed with error -22
>   qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: rpmsg_dev_probe: failed: -22
> 
> The first assign succeeds and hands the reserved region to the VMIDs
> described in qcom,vmids. qcom_scm_assign_mem() reports the resulting
> owner set back through @srcvm, but the driver discards it, and nothing
> reverses the assignment in fastrpc_rpmsg_remove(). When the glink
> channel is re-announced after a subsystem restart, probe passes
> src_perms = BIT(QCOM_SCM_VMID_HLOS) again, which no longer describes the
> region, and the firmware rejects the call with -EINVAL.
> 
> At that point the region is already assigned, and HLOS is part of the
> destination VMID list, so both the host and the DSP keep access. Failing
> the probe only removes /dev/fastrpc-sdsp and makes the remote reopen the
> channel, repeating the cycle indefinitely. Warn and continue instead
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: 6a502776f4a4 ("misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Tracking the current owner set so the re-assign is issued with the
> correct source VMIDs is a separate fix, but I assume it would make sense
> to keep that to someone with more knowledge of fastrpc.
> 
> I aim here to reverting into usable state again which can be also
> backported.
> 
> Tested on Pixel 3 and 3 XL.
> ---
>   drivers/misc/fastrpc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..41943a3d496af 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2590,17 +2590,19 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   
>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>   		if (!err) {
>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>   
>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>   				    data->vmperms, data->vmcount);
>   			if (err)
> -				goto err_free_data;
> +				dev_warn(rdev,
> +					 "assign memory to SDSP failed: %d\n",
> +					 err);
>   		}
>   
>   	}
>   
>   	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>   	data->secure = secure_dsp;
>   	data->soc_data = soc_data;
>   	data->poll_mode_supported = soc_data->poll_mode_supported ||
> 
> ---
> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
> change-id: 20260923-fastrpc-fail-slow-4dc839c1685c
> 
> Best regards,
> --
> David Heidelberg <david@ixit.cz>

I've had a similar issue on sm8250. There the downstream devicetree 
mapped fastrpc-mem over the whole memory but only used a small part of 
it as defined in qcom,iommu-dma-addr-pool. Redefining fastrpc_mem to 
only use that range fixed the problem.

commit 946f65f7f3300741a2c0b6eb0248ccd19eca1925
Author: Frieder Hannenheim <git@fhannenheim.net>
Date:   Thu Aug 6 20:04:08 2026 +0200

     sm8250.dtsi: correct fastrpc_mem

     - fixes spli bringup

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi 
b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c490815ee3a2..f3ac307ed1db 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -866,9 +866,8 @@ cdsp_secure_heap: memory@8bf00000 {

  		fastrpc_mem: fastrpc {
  			compatible = "shared-dma-pool";
-			alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
-			alignment = <0x0 0x400000>;
-			size = <0x0 0x2000000>;
+			alloc-ranges = <0x80000000 0x78000000>;
+			alignment = <0x400000>;
  			reusable;
  		};
  	};
