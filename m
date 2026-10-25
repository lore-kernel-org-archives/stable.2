Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954881;
	b=vPwbMzU2xfHqRUWVJn/dhy2avvlEPpYtA60kn13gNV6eyDFR5M7DYmcjDZaIDAla3awN
	 1eElwbHL8poM0W7bfvQqlqRW7Epha3XS1RxS4oXbzW5jLigu7xVYEnLH935dX7QZfHJAP
	 L3lyjKBiyCgqYAmH826mPy2agBnOEeAJ5x0g+xvdjy13m7A675E/Q8h+Inv3pwGiH1OAV
	 7g2TG4Tbe2AmYOPK7y2Xx31DJdOB6FwQvjVgLHflXOY7pSr1Z6Fy1dD4P8XT2K+8D/Xps
	 letuujCxMRURMUeoCo9jgkPwf4iI1V2tj0enqlHH3s0BA7/eGVVHoVsE0l/W9dYAtDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eep4GL9DCocomrU+bxRgX8heWYBDGizJAyovtrxi+A4=;
	b=V933qgrgrh2B3hCFSNXIhiTAeQ/gzeZyRmSVilRHjxImO72EoxLtGUJ1FQ3ulcHztAR+
	 LASgqfNOJKD3xCE7ltzoTcAhfZq0L3YBtlGitejxoC67+PGEf85umiyNN2sEwZcYNEEuZ
	 C0m1OajLTxMzGEyTNSZVFDcVVJGJsymw4htV3xpom4isyoDJwb9ZAx1V2OiieZilKdhEz
	 3kEyz3ZjyHtVR/4eVgydYZkwZOengXY6pUyG/vD8++kHC7wpOuaVjcjVnMQmUn8ZQrbFW
	 OJHqim36aArjOl6YWyW5F3ZkqySDUUmKc2KjbwUGDur5ZWk4hRv6WohfMOB4fh5xgWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dgMd37vl;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8849606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 19:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8849606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dgMd37vl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1309022f8f.3
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792954879; x=1793559679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eep4GL9DCocomrU+bxRgX8heWYBDGizJAyovtrxi+A4=;
        b=dgMd37vlDpgRiIoYeaa8X5rQX7VWdgW3VUzIzDctagQ5lK23CkVWnctd50Zbyg2lNk
         KUjOU3cedefVLJU3ermhwNQlbmkvuJlFB10AYs2BDe6W4ngbANr3txO3gjaAW37Lf9h3
         yl6zlF2KgPsTeqFo9S7t4eWQdALhNFZDil85qXUhvsgrKvH1v6zMiCSUq3W6aksbgBiJ
         +sPbDrbE3q7+SibdYnjgF9B6yMPuerGvpyhChqrIWD3XxfeHSEPUQ99z+zTbYE+qBiGo
         Fia0jEdb96EH6x3+vPTVVdpfB5V7cJq7L8MnHuGswbBAORU5b3oInu0nPL2CX7KWc6a0
         VtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792954879; x=1793559679;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eep4GL9DCocomrU+bxRgX8heWYBDGizJAyovtrxi+A4=;
        b=TuPUKn696VQ+eXuig7uIi68W2RwMWlzTqPdGV2YYk/Z4KRTwUr6I74UP3boSh20Zgx
         RrXIPDEXWtWUoAEMgyzkg1AkHI8fOg6naJuSA8jnnjUI+oFLtYI0aCdi8bix7J04k6UB
         Rhv4C3AR/6zyyimEwRf9nWjtpmh2d5P6PUQf86mcekNq9AeuPeF+MJQLtJ4eZRPAPAwU
         Agv0ZcN3hfV+O1tnmg68Kfx/NdDFL2UPNY+91DAFCzgIu7rDwbu0PpJbH3h5XEdb/0Gi
         7N/Dk8ca53l/7xyPntMvSYpWz74w9OLWJUMEbQycVw9P22WIuyj7Z8Qbpf6f2/XWTqUr
         HHyg==
X-Forwarded-Encrypted: i=1; AKwUvBwQGgi2kD/668nRuid5q04Asz9SAvTFzypxK/CFU+PpWwGGi6BDwJFqM0BQDJvgNU3OEHSiNI8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0J5pUs98P8cKfjux2fHXpmqlRYo+ZnitgzinxxCon/K3fSS3R
	LfsDccLuPVB8fF+uHM1v94XcgcvnY1dSZ1+rxZOfcw/UFTmX7kf3CefFbP11Me3WT+A=
X-Gm-Gg: AYBFou3Yk4YSPeYbT3H+QkH5Wz4nx+RhM5Gsy3EyBTiCAknk2GoZH+/wizWu1l2EYc2
	ykKY8VVMnf/5ohLWQQkfeUQLC3qX9JsARJyVdla3Hzj6uoTqFu7ibZIOEVYm995vbeHhN/1AOI3
	dYf9xdrVcIkPza87eqXpThlp9bsxaE5RFVzdUCOmk55yD3+afOd7EeortglgRKi16hosW9C2eQz
	mb8BfQvWAQm5LS8LXI0YHSiLFptoq/CEikNKZ00NBUKX4X1DZX+f2g6z6vIT+rWgtwO+kWufJo7
	GocGNLtlcSb9Wy5rnY1K9hEp9PsS20IkO/1i+UeNTQcftOeCPNskLF1NiD6llwiiiPgPPOuv27I
	VseeO10T76zdNFQgTSICY86y9fum601H8cxUqpB0fVXEBXTVbAQvaP8mf79wWTnhWBnI0rNdFcW
	Ky0pGrmNSN0E4SyDH6XqjeWknPuBwUg1aatP2uYBxyjD4vTBn2mfiodkF1ETfwH3aCGmckNdMJ1
	4Yd2PulRybL2XN05Tf30gpOgiK/2Dp26t6OCgIAdFIzDAXp9FQ=
X-Received: by 2002:a05:6000:310e:b0:48e:4300:c6d8 with SMTP id ffacd0b85a97d-48e4300c7aamr8195528f8f.35.1792954878913;
        Sun, 25 Oct 2026 12:01:18 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm10026651f8f.13.2026.10.25.12.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 12:01:17 -0700 (PDT)
Message-ID: <533c4ef7-e008-4439-be40-1aa2a074dfd8@gmail.com>
Date: Sun, 25 Oct 2026 20:01:16 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261025-per_vma_maps-v1-1-c4eec45b9387@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/26 11:43 AM, David Hildenbrand (Arm) wrote:
[snip]

> Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
> Fixes: ea3085dd7a4e ("fs/proc/task_mmu: read proc/pid/{smaps|numa_maps} under per-vma lock")
> Fixes: 0e985559d72a ("proc/task_mmu: read proc/pid/smaps_rollup under per-vma lock")

PROCMAP_QUERY does the same fresh lookup, shouldn't d9d1c2d81797
("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks") be
here as well? (commit tracked down by an LLM)

[snip]

> There is the issue with seqcount overflows that Lorenzo is tackling. It
> probably interacts here as well? Likely, but that's an independent issue
> to resolve.

the saved seq is reset on every m_start() and query, so a wrap would
need 2^31 write locks inside one read() or ioctl, I don't think it
matters in practice :)

I tested it on x86_64 in qemu with KASAN, lockdep and DEBUG_VM on top of
mm-unstable, the maps holes I hit there are gone. Also, the code LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
