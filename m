Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20A388860
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353899; cv=none; b=QyWh07Goxm56gDduOzpRAYI7/RLYm/dOPon4Wb/UvhYvuu3Spn8emqUhCeUy13dNicPCurcb1xEuVKxv2kAJaY6LxayGtN/t/mYEsip3GFFlyulUkmfO6yZX/dnXyS5XgqonYtQy12bSrbLypYFvR+KrNiBFKy5k2uZUp+dQoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353899; c=relaxed/simple;
	bh=TTsQ7/5iVpoqXZRtmKvAJ/ZLYemv4+I21PNUB8I2Dos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncA0Gae2XzFezy6zC/tCWewpQnCbXMYh2i+DQMWUERs3oghmZ5TbJohgy54cf6qz7yJzOW66ZrIcesGXxqc/F2JChkZ5CvSC5usTSpZwZ2w5jmu5hWd7swnkQbrIx2mp7fb5N2YwdHRteWV0tvbSTrlHIF98NMAUx2Pr4fcowhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij22aLjS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij22aLjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788353898; x=1819889898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TTsQ7/5iVpoqXZRtmKvAJ/ZLYemv4+I21PNUB8I2Dos=;
  b=ij22aLjS6f3CTkeuvbwQDMsXzDP9E84vRELWyQ+i5w2bB7BTabpAghfg
   0ngaI1glfEA6Kqy2hpInqqUcviDZ6l4lfBoFH+OyXEXQdbsmKdAdETtHS
   9YvFGdAj+KCSUptKhZjde2gv7UpVlC/SWasOAfWQG8tzsVmTcGTa0AiKu
   AdmoJMoM6WxxWUN7+a83shd8GfQz7oR4X+78uRuChYVQCCg5IooyUzQiy
   j7mVrXXJcvHWCfr+GfseZVVGacgwQjbtdMN5weYHlniF+vFN42LjbinY4
   Fa0cj6jfXKFaVkvkUqWdoLvImldPraZnYdfkikZqckEU8X6jt3KtyPc3t
   g==;
X-CSE-ConnectionGUID: cQ9IZ2aERG2n6ApMcoyfQg==
X-CSE-MsgGUID: Lu2jnuD1QDm+B06seUUl9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88839520"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88839520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:58:16 -0700
X-CSE-ConnectionGUID: 8Oc9YsY/TLKBqtCXA/gQaA==
X-CSE-MsgGUID: x2zyYLg5RKGZRDjUGD8ObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="271369313"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39]) ([10.94.252.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:58:13 -0700
Message-ID: <827834ae-d595-48c6-8213-1e336e704484@linux.intel.com>
Date: Wed, 2 Sep 2026 14:58:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/ivpu: Limit firmware log name prints to
 field size
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, stable@vger.kernel.org,
 sashiko-bot <sashiko-bot@kernel.org>
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
 <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01-Sep-26 14:57, Dawid Osuchowski wrote:
> The name in struct vpu_tracing_buffer_header is a fixed-size array
> populated by the NPU firmware. It is expected to be NUL-terminated,
> but nothing on the host side enforces this, so printing it with an
> unbounded string conversion would read past the field if the
> terminator is ever missing and expose adjacent bytes of the shared
> tracing BO through dmesg and the debugfs FW log output.
> 
> Print at most as many characters as the name field holds, so the output
> never runs past it even if the string is not NUL-terminated.
> 
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260827102339.281799-1-dawid.osuchowski@linux.intel.com?part=2
> Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_fw_log.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
> index 4f9055aa9d33..9eafc42120b6 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
> @@ -69,9 +69,9 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
>   	*offset += size;
>   
>   	ivpu_dbg(vdev, FW_BOOT,
> -		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
> -		 log->name, log->write_index, size, log->wrap_count, log->header_version,
> -		 header_size, log->format, log->alignment);
> +		 "FW log name \"%.*s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
> +		 (int)ARRAY_SIZE(log->name), log->name, log->write_index, size, log->wrap_count,
> +		 log->header_version, header_size, log->format, log->alignment);
>   
>   	return 0;
>   }
> @@ -123,7 +123,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   
>   	if (log->wrap_count == log->read_wrap_count) {
>   		if (log_end <= log_start) {
> -			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
> +			drm_printf(p, "==== %s \"%.*s\" log empty ====\n", prefix,
> +				   (int)ARRAY_SIZE(log->name), log->name);
>   			return;
>   		}
>   	} else if (log->wrap_count == log->read_wrap_count + 1) {
> @@ -133,7 +134,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   		log_start = log_end;
>   	}
>   
> -	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
> +	drm_printf(p, "==== %s \"%.*s\" log start ====\n", prefix, (int)ARRAY_SIZE(log->name),
> +		   log->name);
>   	if (log_end > log_start) {
>   		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
>   	} else {
> @@ -141,7 +143,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
>   		fw_log_print_lines(log_data, log_end, p);
>   	}
>   	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
> -	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
> +	drm_printf(p, "==== %s \"%.*s\" log end   ====\n", prefix, (int)ARRAY_SIZE(log->name),
> +		   log->name);
>   }
>   
>   static void

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
