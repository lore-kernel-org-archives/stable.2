Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008118;
	b=RizMX6aENtKXZYf2eoT28jnKT7rg6pbDGKrXWQVjVvlJOO5J127fJXCPEAAZ8mp7yPXp
	 WqVqoCosGgez2Qnpf21LuZIX5TlIkSQz96Rctk9tYjp64hzewNNUkpRUPpyjNxQjyi28J
	 MWQ4RqBxArOL8riMcZn0KFIZKMtyBZW8sND+AktQqov2BgmUwVa/ynUtyzeyv5soE3mqj
	 zItoBi3wS8rtAqRguVZ3nUjErxWzrxUjqcx+fYu892IjpY3Bjvo6fCSPql/Nfof+4bFBT
	 6Q0Dsv7ffDRinCo2iZwiY+feFBnvP3eZW9o1rQVBwKW5xOxQ1tkxLJ1o7t3Hvqe8hHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008118;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5EiWHwH4lZHEOy9Cv6oxcmHmVFbgWDUAl8vqnSez6fY=;
	b=h7Pz1yiZmagU7JL7COSJCZuHPBbNvGKNbDuEQquVy2orw5O1iCJMJqjq2iJDPeu3pn9R
	 0cEc5TNf5zmRfdPq9pAXmO/gNX1RdbtbnMDxFCWCWIhFaHMH6mdnHIRYn7pEUvRhAWb50
	 OLl72E/UWlZe/Xs2i/eFrvyLNGaO/RamrPdM6+ShVZG37AH4KUpfloVIYXe4wwXT6vdDl
	 kgAUhz3hXJVi1iShB5i1MMIMcGaHWHm/MCkLR1yrLPmR3ZYgBe3k9NVDd85sbNyh7A5aR
	 PniReKYdzVyhktrd9BxT24tvbRV1kyxJU6n6Iwkdt89l4sS5tihJsocpmLZ7TWLDYTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WuE8wfjI;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE5606A32F;
	Wed, 18 Nov 2026 13:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBE5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WuE8wfjI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=5EiWHwH4lZHEOy9Cv6oxcmHmVFbgWDUAl8vqnSez6fY=; t=1795008117; x=2110368117; 
	b=WuE8wfjIZPMMKk2Y6BmSqY2QaEuQu66jnFWIJEaGL5XDL9iN7EcwPrygScJ5XVMk5DnJ8McFdWB
	jTgDCI3r9w+ggfoP33Ef4qRyzyUxhAj+0+3fqijmdERveP87etORG11xxjjSaB75zxCjvp7y0KEzv
	O4Ceuzbw2gOCGR3IY6NDLf6YY8MlHo0MYPzVQk1Tai7RFV0MZE1TezIqXH/8m8UeoNxE/FD2Mo3Js
	JAAB+UFQKWmLy4xcM+/za7Pywv47TFhVKYNVdfmD2zDMoURVzEe3uewwv5qkbzARewkAyRaAZB2r/
	GtxAFp25p6KffKQDrG78/THtlfpPh3ykLfzQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xTfbh-0000000116M-0ccA;
	Wed, 18 Nov 2026 14:21:49 +0100
Message-ID: <c8e13d27-7d16-481d-82bf-6f7cca80a5e4@igalia.com>
Date: Wed, 18 Nov 2026 10:21:43 -0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix double free of query arrays when extension
 parsing fails
To: Wang Xiaolei <wangxiaolei01@kaihong.com>, mwen@igalia.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Iago Toral Quiroga <itoral@igalia.com>
References: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
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
In-Reply-To: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Wang,

Please, be patient with kernel maintainers. Kernel etiquette recommends
waiting at least a week before pinging maintainers [1].

On 10/11/26 03:13, Wang Xiaolei wrote:
> v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
> latter used by both performance query parsers - free the query array on
> their error paths through v3d_timestamp_query_info_free() /
> v3d_performance_query_info_free(), but leave query_info->queries
> pointing at the freed buffer.
> 
> The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> v3d_cpu_job_free()), which calls the same helpers on the same
> query_info. On these error paths query_info->count was never assigned -
> it is only written after the parsing loop completes - so the syncobj
> loop runs zero times and no syncobj is put twice, but the
> "if (query_info->queries)" test still succeeds and the dangling pointer
> is handed to kvfree() a second time.
> 
> Every failure inside the parsing loop takes this path: -ENOENT from
> drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
> between that error path and the job release path.
> 
> Clear the pointer once the buffer has been freed.

This is indeed a bug, but the solution doesn't fix the ownership problem
here. We should actually leave the cleaning process to
v3d_cpu_job_free() instead of cleaning it in the parser. I wrote this
draft of what I was thinking on:

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c 
b/drivers/gpu/drm/v3d/v3d_sched.c
index f29d79b15be3..15bec1e35e39 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -96,17 +96,18 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
  }

  void
-v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
-                             unsigned int count)
+v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info)
  {
-       if (query_info->queries) {
-               unsigned int i;
+       unsigned int i;

-               for (i = 0; i < count; i++)
-                       drm_syncobj_put(query_info->queries[i].syncobj);
+       for (i = 0; i < query_info->count; i++) {
+               if (!query_info->queries[i].syncobj)
+                       break;

-               kvfree(query_info->queries);
+               drm_syncobj_put(query_info->queries[i].syncobj);
         }
+
+       kvfree(query_info->queries);
  }

  void
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c 
b/drivers/gpu/drm/v3d/v3d_submit.c
index eada30a31701..a3e92e097423 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -734,7 +734,6 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,
         struct drm_v3d_timestamp_query timestamp;
         struct v3d_timestamp_query_info *query_info = 
&job->timestamp_query;
         unsigned int i;
-       int err;

         if (!v3d_validate_cpu_job(file_priv, job))
                 return -EINVAL;
@@ -747,7 +746,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,

         job->job_type = V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY;

-       query_info->queries = kvmalloc_objs(struct v3d_timestamp_query,
+       query_info->queries = kvzalloc_objs(struct v3d_timestamp_query,
                                             timestamp.count);
         if (!query_info->queries)
                 return -ENOMEM;
@@ -758,32 +757,22 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,
         for (i = 0; i < timestamp.count; i++) {
                 u32 offset, sync;

-               if (get_user(offset, offsets++)) {
-                       err = -EFAULT;
-                       goto error;
-               }
+               if (get_user(offset, offsets++))
+                       return -EFAULT;

                 query_info->queries[i].offset = offset;

-               if (get_user(sync, syncs++)) {
-                       err = -EFAULT;
-                       goto error;
-               }
+               if (get_user(sync, syncs++))
+                       return -EFAULT;

                 query_info->queries[i].syncobj = 
drm_syncobj_find(file_priv,
                                                                   sync);
-               if (!query_info->queries[i].syncobj) {
-                       err = -ENOENT;
-                       goto error;
-               }
+               if (!query_info->queries[i].syncobj)
+                       return -ENOENT;
         }
         query_info->count = timestamp.count;

         return 0;
-
-error:
-       v3d_timestamp_query_info_free(&job->timestamp_query, i);
-       return err;
  }

It doesn't even compile, it's just a draft to give you a more concrete
example of what I'm thinking on.

[1] 
https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient

Best regards,
- Maíra

> 
> Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
> Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
> Cc: stable@vger.kernel.org
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
> ---
>   drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 1924e3440dc9..a96023b5dce0 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
>   			drm_syncobj_put(query_info->queries[i].syncobj);
>   
>   		kvfree(query_info->queries);
> +		query_info->queries = NULL;
>   	}
>   }
>   
> @@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
>   		}
>   
>   		kvfree(query_info->queries);
> +		query_info->queries = NULL;
>   	}
>   }
>   

