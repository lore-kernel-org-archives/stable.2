Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165203;
	b=krzJHK7DiRgmSriphldgcBYnk7YSXamjm+sz3Vc+rCenAWzIFrWi9q+wM9T8Qv0PjOP5
	 I68f8P9WfLf+hLDXAEQA6p+Be9s+FUIZ9QbiarDgrYhfqLO49EDiW54lxX1xmffkDh4rj
	 KK8oR7hOX+5b+AAnS/bihkFPeQNlwr7ci9alX7WEd1XWmfN+5EGJihZhHiLjfh1djTq4z
	 FpuM0Tpn0wxIpU0z6zls3jboXxoTrVtiqjQo8QuFEbMbmX13DOAVMZUd4A7VpEMHU+LWG
	 zAF2gbQPlG4w0jR3E9GuBdnnE2XCh0HlizqFe6tzqrVI6r3TJQ/RPhL9YchSANN13Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=5NSy9VUbR/SX8a1pHNb7IdxpnGO7bEH3/Aun+Fy4hqE=;
	b=s2QHseSr6RVkBYLhmlWJkEu4ZzIX1eVuEu1eqHIinwu+nxMkr+X1CKL1ZgOJSn6TPPb0
	 dmOSA1n037yxaLpYKDYobyxVN7bAiDM8UKHJhBMnTVLU+ftsa0oqjxiXDz9OXE5oi1XjT
	 Ql1qD5e6Idcvs0xTGC9Z9aikM1LfPnbqLfJVYbYKuW675nLxmsu5HgC+OlMRsFjJ/maIA
	 2xNguUu1Xx3F10re/EaI0t16D9y0aJhNTLRleqCKhRmg1TjtfofSVanW9SnM9/qPqUeKr
	 NMXkG+LoMJrLBkVtd4ahEEkWgecO8sAydJVFNlgtswZ3N0BYdNAxEmOV2bxsrtWr5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORvw0TzK;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC26860A6F71
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC26860A6F71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORvw0TzK
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so5710245e9.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795165201; x=1795770001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5NSy9VUbR/SX8a1pHNb7IdxpnGO7bEH3/Aun+Fy4hqE=;
        b=ORvw0TzKVdVxj+8zBHNAlMac766a7EBPccF+QCmbwRoJRMmOHJiUa/p/qb8WvxATmm
         u0+PqRDxmaYLbLPgt3YZ/zVthSInFc2BtG+wyttr+EoNtO2A01k9tPC5fBGk3jqMlQmu
         ztJ3MOJWYmwuq0FxxN9vX+6ilB0/Nn/G0olA6CMAQWjUc86Dm+zYMcXfSd9ZTHym6sPY
         Uw5tjm5nxpZ4GnmdV/AzvSUVJSxvt8Edlypz7+imIMuugZ0PFVlvcAe0iidc+WVUsv3a
         6t2VaOMqdjtuT85YJ0ahVrFtbFxrC2v4Bu02AdmF0mq+Ha4h9uK6td3SYwOK2pecubnY
         GYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795165201; x=1795770001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5NSy9VUbR/SX8a1pHNb7IdxpnGO7bEH3/Aun+Fy4hqE=;
        b=qJyv6wpeYzwAiDu7JIj6Cc0G6j26l/bp6zYkPRQ7qrjret4nIWp/9Fx8hkK5p6Icb9
         zKr6e4iGcSJk/TkzqFoNMFnK317vKSi/8lLxzYGJMJBcQcH0kpwE2pyvff7SLn+UD9kX
         N01/iQ6MK1queuNlPJc4fR//a8M7+dh18eiEvaxEUCC6dK5q3RqAxy2MhLHiclvTJQb0
         n+w5Lyf1JFcW/ywLz1Gt+qjNarnYm5tdT8TzrbB063AKF12KkIShCXIyuN9m121PpAL3
         UF2zGEGjEui69EHXSzFHUuSUQPHWEwyib06fDtDsFMjgZZG0URbQjFyLRUjhOxlR2Bju
         zqBA==
X-Gm-Message-State: APuU4Z+vP7ogLMXB/QQv0uE7ZbiK+Oa7+bMlC6kjexKZ4lpVZ7ZYsULY
	qBbigWOUCsBs35UsWQHAv88sIkHAaUC9Bw0kb0jr9KEPsd+HeGugBLDm
X-Gm-Gg: AYBFou0EIlHlTrtVvXn1e85+Ca2cHAnhYdjT5gmRg1vSY4N+mBxFXMMd8O9X355kd4C
	gZwHmYElCvBV4s4IYpFtuFrAs5dvGuIfPXnxFr4bDxk5V347ASC4nUc2u6s/kWXFs8A1S5K+g9i
	Tpr85YFo35qpzO5S8mj+0bR0pMzEhPhrm8yLchli1eyQyifF5N7eVhDzOsLrW5Fw4PgN5doMJga
	ksK4151MPBsKjX8aj6oJvDE+yiyYf2GCxG6tTJPJo18/skXDGVwsqFzeG2ISpwaIUMYKvwQCVGe
	co0M3nam1CXKly9LqHtA9nb6t22ibN6R/eseZXKt4piI/SEtamdnIUbrHIrAo26BArGUq/X/5sp
	sYv3gsQDlfgfJaEfOQ++NQuUyNX2BR9ncc2u+yAbRljv4gBHlarFfCwRoEatO9hmvHdJnyFW58n
	druJiHeVmOKH6oFZivSj/XSlvRRvj5zAM8yFI017cdhNN2nurnNi+uigIya4fn5jusBKaBWM7pH
	L981QwEUMjbaEMJMlIxJ3XbslkckWSaMNr3zt9cqBhfMQzdy7/MV7VdEWO65kN0PXrOIuqFL5oT
	3VoCA+I5dULdGBm+zOy6mbrgJlPNooJbWXhhb7pqfb8nQue4eKgm2/zRgpqK/sdS
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr48117625e9.28.1795165200875;
        Fri, 20 Nov 2026 01:00:00 -0800 (PST)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf629dsm3971885f8f.9.2026.11.20.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:00:00 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 705B7DC06FA; Fri, 20 Nov 2026 09:59:59 +0100 (CET)
Date: Fri, 20 Nov 2026 09:59:59 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>, benh@debian.org
Subject: Re: [PATCH 6.12 0695/1756] perf python: Initialize debug output on
 module load
Message-ID: <awAMD5kuizXPSt-7@eldamar.lan>
References: <20261118150007.957976754@linuxfoundation.org>
 <20261118150036.866211196@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118150036.866211196@linuxfoundation.org>

Hi,

On Wed, Nov 18, 2026 at 03:47:02PM +0100, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ian Rogers <irogers@google.com>
> 
> [ Upstream commit 3d13b3f1f3a7cd33d1847a4b87c3198089b6c4a7 ]
> 
> Unlike the perf binary's main(), PyInit_perf() does not call
> perf_debug_setup(). As a result, the first warning or error printed from
> the perf Python C extension hits debug_file() with _debug_file == NULL
> and emits 'debug_file not set' without a trailing newline before the
> actual diagnostic message.
> 
> Call perf_debug_setup() in PyInit_perf() and add the missing trailing
> newline to the fallback warning in debug_file().
> 
> Fixes: ec49230cf6dda704 ("perf debug: Expose debug file")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/perf/util/debug.c  | 2 +-
>  tools/perf/util/python.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index bd968b4883cbd..5b53c9f8ec66f 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -55,7 +55,7 @@ FILE *debug_file(void)
>  {
>  	if (!_debug_file) {
>  		debug_set_file(stderr);
> -		pr_warning_once("debug_file not set");
> +		pr_warning_once("%s not set\n", __func__);
>  	}
>  	return _debug_file;
>  }
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 66d3b0c633b25..7b9b6d464a3e0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1371,6 +1371,7 @@ PyMODINIT_FUNC PyInit_perf(void)
>  
>  	/* The page_size is placed in util object. */
>  	page_size = sysconf(_SC_PAGE_SIZE);
> +	perf_debug_setup();
>  
>  	Py_INCREF(&pyrf_evlist__type);
>  	PyModule_AddObject(module, "evlist", (PyObject*)&pyrf_evlist__type);
> -- 
> 2.53.0

This commit causes the following failure:

  GEN     python/perf.cpython-313-x86_64-linux-gnu.so
/home/build/linux-stable-rc/tools/perf/util/python.c: In function ‘PyInit_perf’:
/home/build/linux-stable-rc/tools/perf/util/python.c:1374:9: error: implicit declaration of function ‘perf_debug_setup’ [-Wimplicit-function-declaration]
 1374 |         perf_debug_setup();
      |         ^~~~~~~~~~~~~~~~
error: command '/usr/lib/ccache/gcc' failed with exit code 1
cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
make[3]: *** [Makefile.perf:739: python/perf.cpython-313-x86_64-linux-gnu.so] Error 1
make[2]: *** [Makefile.perf:292: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2
make: Leaving directory '/home/build/linux-stable-rc/tools'


> 
> 
> 

-- 
  .-.  Salvatore Bonaccorso --------------- Debian GNU/Linux Developer
  oo|  ----------------------------------------- http://www.debian.org
 /`'\  GPG key ID: 0x789D6F057FD863FE --------------------------------
(\_;/) Fingerprint: 04A4 407C B914 2C23 030C  17AE 789D 6F05 7FD8 63FE
