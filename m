Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FB2C15A5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917951; cv=none; b=Tk+8cygpE5CHVzht265kMZBq3npyyZfkY5GKCf4bBXBqGsb7JEelYHoWPtc/uHTvy6SK0uK8QCZJFFSggeJiUqUKMXOflG7NlpZawFjOgc90fsisUVyJC+2ZTzVekVYFLUM0vh8uLQ9WUwM/o0DInLykoZu+1anOYCkrzFvJuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917951; c=relaxed/simple;
	bh=uFmm40Xs4VDVXZUID/cKKi+mu0jp9rrDcS1RS1Ac/R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o206+SzSTgBBs068OY1v7/sXBzqAqXS3NnCu7PirjNFqUA+SVQmNS6C3ZqFwMgqN2eXapzH+Oe/pPtbefM5iX+UOBfyBlVXM+E0rgOmeN3MSDzVmqPHLXYl2RmLSAJOmeFWJNa3mApvnW7pm57r9Y2pFuihYs8IJKa6l5Emmb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv7VYrLF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv7VYrLF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39931869b4aso503022a91.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917950; x=1789522750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjI4DgjlDDON3NUoadRh7LpaMb/RUtoIPEQT63OcGFI=;
        b=Cv7VYrLFEyYGgePryZM3yGJJwo5yTxjsa4MEYPONongxfPY4cMQZesbMuQmZSN+phC
         wFugKYt51/2x41jkdu5Nza6XAAtJWQyDX1PKILaSktuo1r4UfxsgQG+mtAvqgrSCp9To
         EQ4H5KL8/MgtDmN+Iw8dy5W/Uwhdf0u3GekgsmahK/FydOdkjit+C9mEyWjoFH1kOIZf
         0B6Q3WCGRu/6THfkfZdQ30SjGUUKbU8dPtu9FVT+wWegVgO+RIryquuRC+gZLd2fc1C2
         IfaWZ0jbvg8HVt+MAgiM4Kyunl8VF6obbRdB5g5WQyXrnux9lD/2xl+3Dtu1MXXVeVfG
         Lusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917950; x=1789522750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjI4DgjlDDON3NUoadRh7LpaMb/RUtoIPEQT63OcGFI=;
        b=q+5I06bDy3vVYi6QUxqeneht57XiG5kWANUItfDEXYLxZDw3tr3CqcMecfNgsNxY4O
         u1md/BLhy4dgXiD6XHGf3rhz1Pp/2EejICfcM+n3cObUky+Oa86ULe5xLCT7JJIgunHt
         VvbPpFkOpdPtYSUM8tNV3eRuxVD0qZatNPkvN/LZuhCkv7KnS0ae3G769mwPWwwVxXui
         MyqQrpotu8BsIttjRGOQ7ZEHPpeixZRFRyy4A/H2i2x41CQvrijXRIWpdJO8+X2QAqRd
         OvN+0WkYIurVb7HBlfSf2eCZvaxVD/v3VxEqH72epiLEGGNpAVIkvqly5mkdcUNbNp28
         BndQ==
X-Forwarded-Encrypted: i=1; AKwUvBzs6cH6QRtn0E8/6gJWfGgRWTfvQYlF8YLaZZNDubQZHJHjXCVDgDDoQUCbdzuibk6lTbgK/MU=@vger.kernel.org
X-Gm-Message-State: AFuF++nGSdC/2Ev2E3eM56HvnxCfgQnGe4Y5vr5HJi6FFLahUw4/3+5K
	cbZNOTpKK/SINhKBFKQ3rj+p/DZuC37wsC3x2EmGbHV+wPL/OEPD0Msh
X-Gm-Gg: AYBFou02+kY8a+DFgqsn+fpQaoppe97Km9XjYwYtHGXzp/y3NP/wzZkgS8i3RDVHpqT
	jQfrlbm6SOig3TfcNzu6QdTD4enjyMCO1YtY/mo1ed9aXeKOMWqyySyG1cNM4ar7bBy6moknIze
	GGxk/EE8fx7LAG2jbychifElaVN6sQfqMr3MYbq7YoIKc4GEnaWDzUK1FdxjS0UXu0nANom7I/Z
	U7EuX/uIr4WRlpMUhmULWzWaC/OKFnMKBI14q72XdcT6WylZUpd3VBYR/JA7ui1Gu6+FNF5PckE
	xDt0s5KdPIXNwTVUGmq84rrXGVBU9Mft9qYscBM6hMp8JeOGzTJ4FrKlxk/Avo5V62FbpRxEDZf
	LGx7apDOGsPCKC0JZhvEXVrvXD0hpUody70zyleJ7aeMXqGC4bra0T0uoJgH38L0XlKmnySlEWW
	4V7WoLb+OX3H+47clrATYi16aXebr5zgN9qOvGL5UGjYn/Y6Ybdaj/gKZaGc+KNggVTimstTLTP
	O/JTdiEpL+ysmAT1wkZ4sD02+kwkPYnvt17bo2kaA==
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39b3d8377camr26729792a91.6.1788917949644;
        Tue, 08 Sep 2026 18:39:09 -0700 (PDT)
Received: from [192.168.0.203] (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:a805::2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm21198511eec.20.2026.09.08.18.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 18:39:08 -0700 (PDT)
Message-ID: <395cded7-4f9f-47ff-810e-41bed3f8a068@gmail.com>
Date: Wed, 9 Sep 2026 09:38:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: royalnet026@gmail.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, andrzej.hajda@intel.com, luca.ceresoli@bootlin.com,
 cristian.ciocaltea@collabora.com, daniels@collabora.com,
 detlev.casanova@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, macromorgan@hotmail.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908070220.41574-1-rmxpzlb@gmail.com>
 <ap_3zjRWm5-RXKKx@venus>
Content-Language: en-US
From: Frank Zhang <rmxpzlb@gmail.com>
In-Reply-To: <ap_3zjRWm5-RXKKx@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 20:10, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 08, 2026 at 03:02:20PM +0800, Frank Zhang wrote:
>> The following panic was observed during system reboot:
>>
>> Kernel panic - not syncing: Asynchronous SError Interrupt
>> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
>> Call trace:
>>   ...
>>   regmap_update_bits_base+0x70/0xa8
>>   dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>>   drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
>>   ...
>>   dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>>   drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>>   drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>>   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>   ...
>>   snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>>   snd_pcm_release+0x4c/0xc0 [snd_pcm]
>>   ...
>>
>> The root cause is pipewire tries to close the HDMI audio device after
>> atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.
>>
>> In this case, dw_hdmi_qp_audio_disable() will call
>> dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
>> checking tmds_char_rate.
>>
>> Guard the register access in drm_display_helper callback function with
>> tmds_char_rate check.
>>
>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>
>> ---
>> Changes in v2:
>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>
>> Changes in v3:
>> - Add a tmds_char_rate guard in clear_audio_infoframe path.
>> - Decouple write_audio_infoframe from clear_audio_infoframe.
>> - Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
>> - Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/
>>
>> Changes in v4:
>> - Update panic stack on 7.0.5
>> - Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
>>
>> Changes in v5:
>> - Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
>>    tmds_char_rate guard in new callback function.
>> - Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> index 1c214a8e6dc2..8729783d4eb6 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> @@ -880,7 +880,7 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
>>   	return 0;
>>   }
>>   
>> -static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>> +static int __dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>>   {
>>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>>   
>> @@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>>   	return 0;
>>   }
>>   
>> +static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>> +
>> +	if (hdmi->tmds_char_rate > 0)
>> +		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
>> +
>> +	return 0;
>> +}
>> +
>>   static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
>>   				 size_t start, size_t len, unsigned int reg)
>>   {
>> @@ -987,7 +997,7 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
>>   {
>>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>>   
>> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
>> +	__dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> 
> Why? Having the extra tmds_char_rate check being done here is not a
> problem except for some extra instructions. Considering this is
> definetly not a hot path, introducing the extra function is not
> worth the trouble. Just patch the original function to add the check
> resulting in a nice and simple 2 lines fix and you are done.
Add tmds_char_rate check in the original function 
`dw_hdmi_qp_bridge_clear_audio_infoframe` discussed in v1, Detlev 
Casanova recommend no need to check for tmds_char_rate in every
dw_hdmi_qp_bridge_clear_audio_infoframe() call.>
>>   
>>   	/*
>>   	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
>> -- 
>> 2.55.0
>>
> 
> Greetings,
> 
> -- Sebastian

