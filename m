Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6136AB44
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921036; cv=none; b=gId60oCyRwJBZqFxD30RSORwcK8R5HT2MGrUn2DdS7Fi9rhfQuauyKXzkz9oPDuwjyV0Y2IB26NtSDNFhVtwVRL58kblmWcIAPP0jpa9CQZn4induLz4aPIbvJZa2Yy2A4l+8wYX3yVWSnGcVrI+P4UywY5gToIV0+/LJoJo/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921036; c=relaxed/simple;
	bh=QjmjzmWOZHhXJEiEVChe93mYvdYlkxEWk9ACIKrHxbI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=tpZeXPw0VWBVSJo8Af7PwTU4glEFGavOTMv6lMWqw2hTz6uYZqbZHQSDWe2q9ubnDW3lOZ6jqigKPMaIF0FolLE2kRWIdm1QhrqAwOl7FCyfMnQ5ndU/taW58mcrY9NlOC9wJTkCMNLwSO4PaoSJ/mmCVtDtqZX5ghdxuq9o8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=12oclockpoint.com; spf=none smtp.mailfrom=12oclockpoint.com; dkim=pass (2048-bit key) header.d=12oclockpoint-com.20251104.gappssmtp.com header.i=@12oclockpoint-com.20251104.gappssmtp.com header.b=flAoQ6hI; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=12oclockpoint.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=12oclockpoint.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=12oclockpoint-com.20251104.gappssmtp.com header.i=@12oclockpoint-com.20251104.gappssmtp.com header.b="flAoQ6hI"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bd580489dso563683785a.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=12oclockpoint-com.20251104.gappssmtp.com; s=20251104; t=1790921034; x=1791525834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iyTbDvzMeKYwhPCEvsBv2T2yKoX8vPf7zBj7eJ2aaGo=;
        b=flAoQ6hIivgc6oYsz62nlnS5F+tVxxIEikLcINyw7bIuRPpJFnsDwsM3d9BINwv+5A
         TkUAhdNaWf/5vk2sC9ZMJbBU9JIVv6NhD4weOfYvWOzFJvfXh3oDhPBcGMtJIfy+YaXg
         rnGKOEl+K32pi+obZyI5HQ/thE7i+Q8i2EZUBpCyF3w4wFxM8GNbm3LAsHOnuC94oUOC
         x8uOZbq0jBS57BJzvFfI+vXGBG8NNejMYi+cWKp4RJifpuT8NVIidFqitRHc5p4auSin
         6g4aj2HtKDgEeeL/b1sbt6gb0qJFQwqzuhkPHAIBZ3+HMaVSgPmGCEUjqf9dNsV8eq/2
         nZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790921034; x=1791525834;
        h=content-transfer-encoding:content-type:autocrypt:content-language
         :to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyTbDvzMeKYwhPCEvsBv2T2yKoX8vPf7zBj7eJ2aaGo=;
        b=Jj0iRsEJxuMXFrz6K4aU2mchTYaBLX9QvHwTk8Tyx9l+cBEAORSFNsBTQCdUuaTaJq
         ciSMG+RR1hqt+CvIQklh+DKqcadZOXszi22SxRbeCc0CEo3GFvSKxpOVsi09TQaLm1tW
         gUYUFXFfpb/N/rHnGPNvkEmCEE7lN5pIlzanT3hr8qjQKISDe2uTgffmlv5/Wz5/Kv1X
         QVQmQV5duZ8smj3VxoCA4XyxmC2dXumW7z4bwDUp3rfbtT+4Z+cBrbWCyKDsAoROZLUE
         l//bAiSNFedlPfBL9IFfvGs/81jaM5i2taDG6SsNzVZU8q6gsEpWdauEPlQpwBQyhWaH
         Ez9A==
X-Forwarded-Encrypted: i=1; AKwUvBz9wbWb4MKZYIhgEAd6NVZCgRPgZimojtRx+swMdGo/GAvUgUwRTsJLsOJD3OgT/thmQkxjQMg=@vger.kernel.org
X-Gm-Message-State: AFuF++k6cKDAi4eOkPVF5w+kWiNB9B80WfYnaqzu5e9deK8KNsZC5ZqZ
	YPUfm9nMqtnXqzmKnNofJQyFyl86TSOstQ8u26LSRzGi59axWPAIeMjKvO55tB+jWn+zU6hxnC4
	qFmBm
X-Gm-Gg: AYBFou29iuPcsyrRuCg53PLw0NmCXzeTQKD/OZ3Gi9S8GhNYdFGaw29Ce5D+M8L6Ya/
	6zI7XXWFiH2BnarzIwea7rFZ5wSCEBpMIDDA83bnqn27gQYNr/Dn7U34V+/5CUvR6Ep0ekdQLHV
	NnSGsDZbJJZWyziozVG8emNJcwbX3V1zH5+BEaP9Yqnh4cjxQ9qdzMPI16bHwBVXeeoEW2Qzvr9
	DiDJmiTcgMsu5wepZGzHRZAJPOLaMtfvIu2gU0roHrPhBuwoqJXhdnttQN2TMq5i3iB71aFlqXK
	gOHvrtguT7wLosh/rY9NiXQEPnXyyBg65LEAH7duCasGna6ggWVEzvAWn9m4bpO+C+p1NMEijpG
	v9ciixJTZvhLWai+qK0M4KfPndvNKHGLHVtC3dF3kiGnqs75xLdPKV/d0lpA5lzWzQCxppSP3mQ
	bfoEhWfrigSVuUT0WZjrzFcYoelDuIovKXE2DuTo/KTKqFSy4+OJjtlrVPZVrVxm6bSIApsPVku
	A54v8u56CXWlXXi
X-Received: by 2002:a05:620a:1a1b:b0:93c:746d:7c6a with SMTP id af79cd13be357-93ce920fd9emr276576885a.10.1790921034134;
        Thu, 01 Oct 2026 23:03:54 -0700 (PDT)
Received: from [192.168.86.41] ([142.126.42.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm140331785a.47.2026.10.01.23.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 23:03:53 -0700 (PDT)
Message-ID: <9404c689-a95f-4475-a53a-47a724f6784f@12oclockpoint.com>
Date: Fri, 2 Oct 2026 02:03:42 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: solonovamax <solonovamax@12oclockpoint.com>
Subject: [REGRESSION] drm/amd/display: screen will randomly display static on
 high refresh rates
To: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Content-Language: en-US, en-US-large, en-CA, en-CA-large
Autocrypt: addr=solonovamax@12oclockpoint.com; keydata=
 xsFNBF+V2DABEADBXJYEHk9O7/2YFInp/pCL4qBmk8We/LAx4jJ1+/I1ELJxOkEbGMNBCN8U
 WP1tSgrPoWTKFemKY7M3BNBJYrO9mY0jPE443qEucCuzqHixgzJ9vyzwDAa0hFZeat6p5n4r
 l1u0ceYXSNvKED6KViayS17+9ba+JglT/UzCPadOYziRTRmCiQCZLwrmY4vmW7iiveYT8SIN
 hQ8nSc4pFhaRdJtuKMwBnFunOogtV/4XbX5Bv+Uk8AkZAER+8xPV6ByizCmfzqBPPuwTP+Wf
 +OY8PLwvNB9jDsPcroMDt7AE2TQ5zJK0HSPBPbh8oYgX8rJBEpnoQy0NsFJwrSDA9Qd5T6qN
 nHyUTAMpastKfDeKQDhdbkB95gviZ0rPm50G4gx/BuB4bL4A3Wzy7AKhsZhMjUk5SFg+zdxV
 V9LdogmcmQizoBWDiyvs9fzuB2c4riiPGxm51S8PSmjyBPSigrOldnWTg6Pf0TaIyqt+JrVH
 2HunRkrMEJg6TvmzwySfHZkvgk+DBif8V6+opNU8q6Odz0AnVKs96fO1YFXcsSBPlnhBUvfp
 y45atJHVqNmJw/3sRdujgEi68nh2WFt3znQYLd8xzMBru6Au+hsKbafzKLBJx88vL9QwmFd8
 rt3kN/JWlEOtAKRc6woe5Nj5CYAnfvYeXY20VgiNqiB+SA/lVQARAQABzStzb2xvbm92YW1h
 eCA8c29sb25vdmFtYXhAMTJvY2xvY2twb2ludC5jb20+wsOrBBMBCAJVAhsDAh4BAheABQsJ
 CAcDBBUKCQgFFgIDAQAWIQRrQtQLTMazAY8q8gntD8LUTNdkggUCYddFWmoUgAAAAAAQAFFw
 cm9vZkBhcmlhZG5lLmlkaHR0cHM6Ly93d3cucmVkZGl0LmNvbS91c2VyL3NvbG9ub3ZhbWF4
 L2NvbW1lbnRzL3J4bWZrYS9vcGVucGdwX2tleV92ZXJpZmljYXRpb24voxSAAAAAABAAinBy
 b29mQGFyaWFkbmUuaWRtYXRyaXg6dS9Ac29sb25vdmFtYXg6bWF0cml4Lm9yZz9vcmcua2V5
 b3hpZGUucj0hZEJmUVp4Q29HVm1TVHVqZml2Om1hdHJpeC5vcmcmb3JnLmtleW94aWRlLmU9
 JG9hbGFNYU5WLVpVME5NY0dDemJsd05NQWFSTXdZVW9qQ2VvSGZEZzFIVm9dFIAAAAAAEABE
 cHJvb2ZAYXJpYWRuZS5pZGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL3NvbG9ub3ZhbWF4Lzk1
 NGY1ZDhkNDc5ODU3Njk1N2JkNDA2OThkNGFmMTYyNRSAAAAAABAAHHByb29mQGFyaWFkbmUu
 aWRkbnM6c29sb25vdmFtYXguZ2F5P3R5cGU9VFhUNRSAAAAAABAAHHByb29mQGFyaWFkbmUu
 aWRkbnM6c29sby1zdHVkaW9zLmNhP3R5cGU9VFhURBSAAAAAABAAK3Byb29mQGFyaWFkbmUu
 aWRodHRwczovL2dpdGxhYi5jb20vc29sb25vdmFtYXgvZ2l0bGFiX3Byb29mAAoJEO0PwtRM
 12SC4XMP/jNjHMNxqcjIQ3EveF+WwKUhxoAoP+eIm2fmlAvaZ2ufvcBq7toK95b68IARyh6b
 ysOJfAuXYPEpHAePtaGutUXHb96Uwlu2MnYwpyJyhzxCoMAYQqmh0JdE97Cn796TGdLfSzI4
 /BYAvz5MUQXi3ezow4y7/mt/R+CdVyHuedX9epHwgJJx8nsiX9Eg95H8pnKh+Rj8MO9jf6Cy
 GwK2QlgKo0qgV5VcvSEA1Fp7HgQQ/OgVqGegUrYAXDDJTBvt+fcHQRlpyOhUaB8bnlMSgW3B
 49zk/sWb13w0zlPR2FoZR8rZKkkSC0eiIOqcJbwjns7IF5pUCTgz9pnSuDI6sl8wEFRGPGMg
 Tcwu3QbuIVEJrgx8mAH7awoM8ajaj9uVXNJIfv2jr2Rks0xGyUQepfJrUKKVRBnhQZp6Vn4q
 zpaR0qFGfVquPQGaBKxLpgg8cnnSGQHNCBz4Yiph7l3bf3jEVHOKsROQKYpXjM7dWEuVeO2P
 xSFpirbMObo6n3DSy3t8jUHcZi8RL5lllmGYQLDBJ4Wd38Fv5uisDutrXY3W4eL7Q8o1Px7E
 mNU2MN9oYf2eCZjNruIWiOInJXWqumCzuY9PXVW2nx9vmxvNUQ1Oj8RnmXR/WbnS01YhJPeW
 j98Udc5aVvlNPPZEx4sWme7WDdeFZTyI4b0dPFA3hTL8zsFNBF+V2DABEADKsjnQl8i0j1t+
 rDZcA3y75JgEkDZvRQt1uH8ujmINKYA3/AW5oQHlFj7zCVzC24giMYoSFg+RrX4+6Ds7dcjZ
 DZiB2S4+LYHF069V0r1CWUMv/PGIgP4vDepPGm65OPZEiqaEnobEdzlxgg1Z2DkQl42Q805h
 SHo835NZReVEcCvMei5h9nC4ACYFM/2fCTAoglKojoBIgEQ/fLP79E+ztSf8gTXGFnZVlRx3
 Oe5RWFh/m5uY4iCO6U5cSRla8trUo076bo1/btxuWwZqYLXifzBbtm/Emm/ZtNOqeANlTCzT
 u2oHvqCULj/hz+uNLlM6YLJKgTZrXPmre7njD4Meng74ddMByBoNO3vTuujIHHc9C4shltnP
 OLVL6L6uVcJBvqQAKEcr2lPyRi7nNbUPk1Y70RcukBsFEQCjoZYfBvzzwV1pv2QUK7yfm5pw
 Xp9LAtS2HSk45H2zca3nGlBbBywmzl6pqFP2xh6RUtzU01yA2/pU84QdUm0BdhNk5J7FUTWt
 E8x6ZrVS9uCDDbjM1oVequH2S3Mv2T3nc0CpscUyjXHvTi4g8ISwxDGsetv+lr3i1nimM4y6
 bvj6PwmVZgLcJc1rmPYUnGSMrA7occXN504ajAnkZY8IMmGWFdeZNPnlgOiG+6JT+jIdILSz
 nUS7pbdJ4VwPQzJuXmPWXQARAQABwsF2BBgBCAAgFiEEa0LUC0zGswGPKvIJ7Q/C1EzXZIIF
 Al+V2DACGwwACgkQ7Q/C1EzXZIIMgRAAjU+aaplTp1iWpol3JtZiBdfQ9D+nVC0wiL0JD6FZ
 opuyXWTJDVzC+RcyZBMyiMTDiWj2uF1r5JvvLwRMmz+z+AtGtBWgFR9idIjHvSqOI+C5D2T6
 OZx24g3C9/XUwaeMajcyxwY6/1lp5yGprBEGOtizechRvivNDGYxTohbuCPVdVeIx8R1lQfl
 swz7GfMLUjqg+kaxMDO89ikVqB/imZ8w44O1P4NpjpNm/202p6cWBr3TmIASGry2BpB07BYn
 nEAVHF2hTtCTKwClRMW6h2ieTUwKrYm3ouHoiSvWtzns5GAG6M5Ai7GVfEAe4h8UTwfd/NJS
 ov9IdONk+cbEINzaEfx8bUbwNZE1/J299SjFfXpbzcxh5daaLg2cKiRKc2H34az1Bd+RSCju
 2nck1V69RSHQvNpq4cQNw26t/0Aga97/Y03R/p77bMRHNkjTRv4WQIHXEEa9Gf5rFc263jTc
 wqBj5/iQ5HDci721KVmKJgE919DZVuuM99b/vOV7ZdMbyKykHZDqLgmepkHvZ9uCViVSyNjX
 fsOi77igNyI9gv3OSvIHQd+uNmEn1WBDk/G3egI8Gf4DfxKKf9UAt09npwkgwsVfV2JoShQ6
 yRFzP2ddxYve9dtpRT7cyiuDZ+HgfzwPY/MXqpURBw/t/glbCqs2iKh8IPB9mS0a7jI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm experiencing an issue with my laptop where, when using a refresh rate above 60 Hz, periodically the screen will display static for a handful of frames before going back to normal.

There are no messages logged in dmesg when this occurs.

I bisected the issue to bf3fc94cd72abe6fc6cd88691fa98f817f4cd6db, although I'm not 100% confident that was the cause (on that commit, I observe slightly different behaviour. In addition to the full-screen static, there are also rendering issues that appear when some surfaces are being updated). The issue does not occur before this commit though.

My laptop's built-in screen has only 3 refresh rates: 60 Hz, 240 Hz, and 300 Hz. The issue occurs on 240 Hz and 300 Hz, however it seems that it occurs more often on 240 Hz.

Setting the amdgpu.dcdebugmask kernel parameter to 0x400 (disabling panel replay) causes the issue to no longer occur.

System details:
* Laptop: TUXEDO InfinityBook Pro 15 Gen10 (AMD)
* CPU: AMD Ryzen AI 9 HX 370
* GPU: Integrated GPU (AMD Radeon 890M Graphics)
* OS: Arch Linux for bisecting, I used stable/linux)
* DE: KDE Plasma 6.7.5
* Compositor: KWin (Wayland)

I'm also more than happy to compile any patches and test if they fix the issue.

I'm new to the kernel mailing lists, please let me know if there's something I'm doing incorrectly or any information that's missing.

Note: I have not tested this issue in 7.2.8 (only up to 7.2.7), however given that the files in question have not been modified between 7.2.7 and 7.2.8, I don't think doing so is necessary. (Though I can do so if requested)

See also: https://bbs.archlinux.org/viewtopic.php?pid=2311113

Here is the hex-encoded EDID data for the display:

00ffffffffffff0009e55f0d000000002a220104b5211578077335a7544c
9c250e505400000001010101010101010101010101010101606c00a0a040
64603020660049ce1000001a000000000000000000000000000000000000
000000fe00424f45204e4a0a202020202020000000fc004e453135335144
4d2d4e5a320a020502032400e3058000e60605016a6a48741a0000035130
f000006a486a482c01000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000ce7020790200220028bf2a1585ff09
9f002f001f003f06630005000500ffee1085ff099f002f001f003f066300
050005002b00122700782b0100270064ef00002700303b000021011ddf0c
0b08000a40068866fa53c8949851120e023554d05fd05f003813782e0006
404ed05fd05f250109bf2a15bf2a153c2c8100000000a790

#regzbot introduced: bf3fc94cd72abe6fc6cd88691fa98f817f4cd6db

-- 
Thanks for your time,
solonovamax
