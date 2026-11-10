Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302344;
	b=rCUzX4n9Ie8r7h/MtM7agqEmfWsva4e3u3Ldwk+EaoGgb/2XiLHbsjYg/B2JgA+TZS4q
	 uqIBtLAnxKduXvhShhglYIWczT67V0yx1hycvXWr//i0vmkPMev04QaZST5YPuxyA0ZPO
	 CyidK7dRDeSYNaK6/KQ1o3lE9I9NRmSedIHBCqEEA/4iL7LrlnRx6qO4Cup9wivlIsUex
	 r0A8Svo3LHDOXWosfUtmyEWYH7c1m8uJNKkLJHE+loGd9kra7DYy6YQ24hUe6pZ2DPRza
	 DBPZjBdWGir0Q9au7rrP/tCC7b/H4MhUwDfBsFjROujV19B95XXV4kzYo6brnmp2tKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302344;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RrfbhJhpWyjn5vAaoJoaKtZ+zVmxKxTyBXnZ3krPL+Q=;
	b=a0m+iUT0er1tg3VUqRbybgfzcPpJOdhPkbBq/YM3/xbW+Uc93m65mDCZig8edqNi2HAY
	 s7S4UW8L4FAuGAn7Yj3o+mOtzQx+pszUHF/X7vPeFVRH2zPVfR/8CtVESU494bz497Wjr
	 4dIVLrYfYeXoa/uQ/pXR7FoKQUgzhpod1UzZJHhnSyOzjWx4TmguzO7rcEW4eGvxMLIKS
	 VTs0lum1dA3W7fQDNpcD+Axuw1XsCmYnVRz0fv8bJvMAST927BVercXgJoZWJGZmMCrbw
	 9xIF9MlxxqMmkScczRRQjvivHRv5Nlt15mp9AUI9qQVo9thzMZWH2/JVGFnaEVSUopQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lGdQVQDw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D9rlfne3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4B6076135
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B4B6076135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lGdQVQDw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D9rlfne3
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7krqH2770432
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RrfbhJhpWyjn5vAaoJoaKtZ+zVmxKxTyBXnZ3krPL+Q=; b=lGdQVQDw79Sh9JG1
	8t+u/9SE1w9T/GDpMW3jqAX6AqQHlngxI3rIix8AENJ8NV/bocMLECKXVkTVsXt9
	HXa3CMR2BcGNT28XH5HhLRl7rEFy4Wfp0YtPiJ9iGgHNXn+RbzCenwWA3csg7/DB
	s7P9Ezc/8AlMmofHYtop9siWG4WM391uMEda3DhZkWDi7VF7n0Oz4uhqywfU9dT+
	gcclxyMxa8U9lUH2HWAq7laq5FWoWKrnVMsoeYaTUYSo7MsejR3gKSUtFXjruPre
	Wdg2TLtNGyxodwHNkfWr927hc9gwlUTpjvxpoBzVFQ19Yhod1d9pjMABT9tXXXXI
	sdAt8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd90u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:19:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f3969a2a7so301451485a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302342; x=1794907142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RrfbhJhpWyjn5vAaoJoaKtZ+zVmxKxTyBXnZ3krPL+Q=;
        b=D9rlfne367rCgEygX1PJDo3QOph/XkkEJGMhkACe2zabdEKPbzX9O6ZAB/lzB7K6jh
         nhzqkJZRl0VGn+M6zaxT4brLSrB5YvD2aXOOIN+RJ6U2LNd45T+qtmPheCfcAZUTOF9D
         Y0li8Hug6CUyUvmtDFPRNTIDrn2xX9qy33SWoNil/2wWdLW7aVfNzey+bc2YpDSNhi3w
         kGjyI0qjhCuDF9MHtvA07pByHMIF7Lwu/jvr1clOzGMYODXMrepf05jEGqQLhN3fsTg5
         WghT5bC3PkzD2w01gIn4Pq4Sma4fS3GSI60mEPJfSMSVTvUVNUEp7yZQdyu3fYYQWD7A
         Bbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302342; x=1794907142;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrfbhJhpWyjn5vAaoJoaKtZ+zVmxKxTyBXnZ3krPL+Q=;
        b=ZL9xDAlRWu3SbJo5cW4uhGSYRCrVekCLzY+YPE7E9cWgUxxCZkBIPtkFiA4vgQZkdd
         YBxx4dV2Hi5wwT5nc9gNNlTAZYyXkWLTUhs/MrJU5bKHMkMJt6olG4JnhDpa5wu6UGav
         8NAzubhxWdFhBaKTlqYw5vxweQ4JKDkFK0bpHJZajjOxtp/nolGboI1oUpAyrgb/rxik
         l+AQdsA6kv+E6XfhS8zzLRsWRb0VQg1xqSG5YFnWw5K+skPR8u4eXEBp8pGI4P3Zq3L4
         HfgPctp0DOr+MlFMzrtpNUt2a9cKOX1wyBM6c40UHhAGazZimiufLtQl5PfcImZd5F7v
         Mhgg==
X-Forwarded-Encrypted: i=1; AL+hErGUTFixmvrXCjPUD7u4P9zLwE+1qL39nqF1Bd9MfrStkCKOdAIIbAuMt4Z3YP3dkK1Yerie/Kk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q3t50rU1i5tWd6clewRok1gIZFK3MxcWfy5CiWhw/F54FtL5a
	sqLT1IPapFirQ5cnAtyga7t97df5sk4QzHrZolT4PCzXsQXKroEApX9NzP9KkV2EJu/7tDQWQ5b
	m4k4LBL2U3IabfmW8LPKqEzCxdpnhGGLVBCtrmafwaCBovlNVcmhzZXzWSJDnAi7OjOc=
X-Gm-Gg: AYBFou1Id5jYd1QWiS+akLUs9vnGqFzPQUt20TApp4N5hSGArUg1wbjg09mhd2RoqNO
	wvqWTIhGAj6XxRuX3EX29k+Z16cClOa0Q3SK67HAj5HisKv8vCZpArLIbtZOPM/R12gGEWqbZho
	f+hkkjugI5v01Au690isQCw0lUULP5h2iF2V886H0T3bWB+llWdEvpQh2j6I5xVnhPqX+v8DvMI
	JgmRwqur78wWyqH4db46u/Nyq1LnxpFgS4aVhmHOZaqtLuR0myETbcbuIl4hStk5IU1JJYUNTCx
	IlVBV9llwnvrbvb3kz4Q4Q3AIkxkoBUwUVKK4bpdKmvwQ0DwiZWhZ/QWz0jE+7yv7P3yaWx/DuU
	1OwEJD+XPTUgFz/iOs8Q1hhvG9rlZTlPa2brBoUKLEASzXsKgTkHb8kGGllpsvCtFP8DvUQPwNL
	HCTZ4YrqL97k47lQJS+C83u/S8mafiSDhof7xCLJ3GhrHJ+2yUwt09KhP0qLdeag==
X-Received: by 2002:a05:620a:319e:b0:93f:633b:ee1f with SMTP id af79cd13be357-9479f2b50c8mr335995385a.28.1794302342595;
        Tue, 10 Nov 2026 01:19:02 -0800 (PST)
X-Received: by 2002:a05:620a:319e:b0:93f:633b:ee1f with SMTP id af79cd13be357-9479f2b50c8mr335993185a.28.1794302342156;
        Tue, 10 Nov 2026 01:19:02 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fba476sm60276505e9.2.2026.11.10.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:19:01 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: synchronize updates of descriptor labels
Date: Tue, 10 Nov 2026 10:18:59 +0100
Message-ID: <179430233645.6529.8490191928778846102.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
References: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4POsdb8W_LlRwxKO-6ng2bsqLxsDJzAK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX6iVtarkhvyNc
 EjiuNnaGL9DcVRMoxk4NqfLRB/d4lpkty9835zG7/H2PZIFTa+wWq5vBTgSpNrIE6rISNib87+t
 ywk/JmLYyX6jxvMlT4z6fxihEt60pHQ=
X-Proofpoint-ORIG-GUID: 4POsdb8W_LlRwxKO-6ng2bsqLxsDJzAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX+vsSksslKlgm
 7w54xzfLa9QYb2PoK9W7E1YUsWDwwzgHPphNIZkwd6aCj0dkzr94qkySMeo1/AMdbgLICliqwgt
 Zxocic4Mf4GKociMbPf4CZ5XfXueoN9XF+R2wKMPAUGjwoH1Afpzw1qc0hEjmk2YSS4ni0UdBNm
 /wM8AnjaRTuU+BgowdT5tsyVrpPSem4SFhfPUJofdnDmB5izjQUzzzYjADZMOB75Vtemms0qRE2
 maCJN9EhvgMssNP8c/JKAZCAxe2XCsu5ubBBEFMDI7hIhg6TLLj9CmyblFBRHeOjmZ8Os8xuqef
 b/ZszVLkUWqk0QtfHM8Zc3b0jvYgv+zEACWcFNqUu+EgAtAeSqWjC9BvQQx5hekWpfulDk2GHoX
 4Y/mHO500f4uBL+elLHtLKwmi7YF1uSMceMyJqCTZfyb7qQh4qTTNqFN8JBDyraR68HI1bfo/qL
 mLht2Cu3o1s7fqDDPcg==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af2e187 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w_KnAPlzl-2QHVUEQtYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100036


On Thu, 05 Nov 2026 14:23:45 +0100, Bartosz Golaszewski wrote:
> desc_set_label() swaps desc->label with rcu_replace_pointer() but
> without any synchronization of concurrent updates. The swap is a plain
> read + write: two threads can observe the same old label and then call
> call_scru() on the same SRCU head corrupting the state of the chain.
> 
> Add a spinlock to struct gpio_device - we're using a single spinlock for
> all descriptors as using a per-descriptor lock would unnecessarily bloat
> the size of the desc array with very little chance and no consequences of
> contention - and use it to serialize the pointer update.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: synchronize updates of descriptor labels
      https://git.kernel.org/brgl/c/82028344caeed2ea3536708906adee02e472633d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
