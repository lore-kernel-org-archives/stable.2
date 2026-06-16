Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E137BE7A;
	Tue, 16 Jun 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574147; cv=none; b=Id88kv7pX8i8tnmibi40QqKsHMQiVstbPFJhd1Hj1GPjhZxyy7xsqFHWKOx1xQfBA1mY2ZkDiEd+q5b3PsWiOwQ6JZ5B+cEtKvKvwmu3jx1aYnM+UZOyPtHlxstBLrmKPAJ8N4uEhta+hQtYWR50/KeESiHZ4z2BJe9LLbfr8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574147; c=relaxed/simple;
	bh=u6ApwQNKW9ESpposHwjyUT5t/LeS8wwWSOugVRDoqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDdsU8N1/Gr6qQRuVs5dNa0WqPd7O/Cj+UC4WZzUg1gFhpDz8GBKSVhQ7jt3u6KS7JhDH/FaOK6jGBEYyg+AxQ6dahbx4J+f0wN/xnXHhA991oono8XC50TZjkrtv/ESoBQ9K8uegLZW3AOGhdh+o2h2nn8h0dWW5zFRToBPN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HMn+4N9p; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HMn+4N9p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bfKNs+epJgX7p0qKpOy6KZQL+Q/RyTOBkRnyXEtEQn8=; b=HMn+4N9pjHZVSgSbOz913o8IBq
	G/pWzOI/lKBipWN6rHnBELqy5kopN/hpVjbstJOe+jZhyUrAhHImRhDU/v6Sw9k7FtMtYt8aVkmWJ
	8nwUtr5LRONrawUbENpPPwmMeSfFn4bX0uP3ueNKdo6YiSY9Pny2BDXTc1afvTjNBnh1x3Mn3p4C3
	AbFDvSX8Uy0c9BBZkJyy2k/Oba73N2S5d6yq/Cyf6PIs84yKyww8YMyUmCdu10iSnPoMJcNmrVGGC
	Qmcc6A5dcPXQ7Rg85Le4eXEbyhwj03wM4Jq+Wp6FyL+y2wf5MH8DhNrMViVCpxp2jrjXEN0ehOafF
	052zS/RQ==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wZIob-000iFy-EG; Tue, 16 Jun 2026 03:42:09 +0200
Message-ID: <1b7f8dba-281b-4184-ba9e-d550b9a7ea7f@igalia.com>
Date: Mon, 15 Jun 2026 22:42:05 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: reject an invalid indirect CSD buffer handle
To: JaeHoon Lee <dlwognsdc610@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260616070048.1590551-1-dlwognsdc610@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260616070048.1590551-1-dlwognsdc610@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi JaeHoon,

Duplicated patch, please check [1].

[1] 
https://lore.kernel.org/dri-devel/20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com/T/#m42c7a8cf94b8cb787cca01dfbdaf5fdce40c7332

Best regards,
- Maíra

On 16/06/26 04:00, JaeHoon Lee wrote:
> v3d_get_cpu_indirect_csd_params() does not check the result of
> drm_gem_object_lookup().  A bogus indirect CSD handle from userspace
> makes it store NULL in info->indirect; when the CPU job runs,
> v3d_rewrite_csd_job_wg_counts_from_indirect() dereferences it through
> v3d_get_bo_vaddr() and oopses the kernel.  Any unprivileged client can
> trigger this.
> 
> Reject the NULL handle with -ENOENT, as every other GEM lookup in this
> driver does.  v3d_cpu_job_free() drops the reference under a NULL check,
> so the error path leaks nothing.
> 
> Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
> Cc: stable@vger.kernel.org
> Signed-off-by: JaeHoon Lee <dlwognsdc610@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index ee2ac2540ed5..05f98379c1a4 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -605,6 +605,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   	       sizeof(indirect_csd.wg_uniform_offsets));
>   
>   	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
> +	if (!info->indirect)
> +		return -ENOENT;
>   
>   	return 0;
>   }

