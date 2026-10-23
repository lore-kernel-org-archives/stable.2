Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741727;
	b=jBHxQIrlZa1UVP2mwcgvvhBFykO7q8VVh5lUi0c4k4M5d/wZDWjA+upPdFrN0AVCupx5
	 +zteOgRwA+u6pFJ76om45TBInFixRFxt9gCL8Y67PgdgYJMH8XAvMG9XOjs9cq9LD/gGm
	 t+x6FnxshTnC0hUY/wuVeSXgO+DiuM+L1FzKb1M/e7K3t3fVKwqBfDgqKlFRAVwrnij/V
	 2er0hsXdOrQQqn3ESjMUFeELaFcfpyrgUCGqqGVF3NtbkX2/8PaCfGanAemnu4VS51AZY
	 oTbIFPIw1QFa4U6p4tAM784mH1MWAtrTDCpGsFGvuvzwMxETQVHJ17vT0WeepejBqIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fLv/0ymzeMVr3+DKh8bjeYNHCYO4plYAT47kOv5TlFQ=;
	b=BYDAJQmuRk8IsNxeohNWSxV0wglWvigdrGcY8b/s4+jpdAWj/tYBJTqaM5L12oNI2Uqk
	 SF5qxOgpHHG/L1zPvMpun/UHhpXh/CXsW0Ci9J36TuErPt4l0b2A5uv5KwMriw/o8Ok86
	 Mx4qp0mhgVk4vJgFs6kECCkmNELQZRNcrpDzsNpBRrXR5PSe/G0bQS7D4dRalPxS3RtJJ
	 WEv9HIwP1SqAIi7aMqpMD1cWla3NJHhgfRAQwNT2z+hXa7P7yipq8KVpMtktb3oBJZVFo
	 GrNexXr1nMW57G1ZvUON0mPdx8EgYMY+oMzFQ5gXSq65DsLKSUcRKK/u8BZc+Sa/LMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IMlpTlFv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YV8B6wTU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B333606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B333606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IMlpTlFv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YV8B6wTU
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FMod2572481
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fLv/0ymzeMVr3+DKh8bjeYNHCYO4plYAT47kOv5TlFQ=; b=IMlpTlFvxoBxAxXm
	p7jT6BKYAdbg/r3GC6dbD4v9nGNAARHZ2+Tx1TR5A3OIrPiwtRJGLAJl2Oh7Quka
	h6k4U32a+LB1xV7itulAT83M8UsJXelcubR+kmVW2F8WQk67a11j1g3IuVyVd46J
	8Mlnas7hK4G3tMjIR/b4QeDGlNtKpKcmd8jfPT5o6eqfVhFAmLLj1KRI3EphAR9Q
	pkeWbVRA+jgPEHIe/yVFhj8BHzPt6jt8RVaHA57Smkwu9LnZ+uIieUxnOS5YipMl
	9xPxbDnfDwLdcPxkVavuML/GYIlTa2X7TVssTSUOypEVqpjlcnNHlwrQwKTK0zxd
	RvCnAQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0k45k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 07:48:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so197198785a.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792741725; x=1793346525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fLv/0ymzeMVr3+DKh8bjeYNHCYO4plYAT47kOv5TlFQ=;
        b=YV8B6wTUT4AGdtm5VAQ8KJgYQY7a1Kwo/X9ZGYYZES2D2bELSpEJOkMDBzmH3Vw50G
         LNTtnUga1KbDfRViBAPNHFbS1KDKCcwrn4vmHrVLZveDQYKKy5BB9XA3r1IqouD41wXg
         yZ2bmucqqbWhC50pvYYX5og3pcn0SZcrWIacM6UoXPRGGqvMivdEXd2hwhDj/O4q49x8
         wxvLRlgodiPekVJ6kF01GtdC+7M9yIv8sXfiveYALHmbH9SBFga5kNy6Jd0ZuBr5HHWu
         TLYRc5sQlsfqetbjHxbVBMctHzk6DKVj0ZbAwpK8mwaui7aMomDwNJpLMypQKtSHz2B8
         cg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741725; x=1793346525;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLv/0ymzeMVr3+DKh8bjeYNHCYO4plYAT47kOv5TlFQ=;
        b=tuSm6qncJv+pMWwWvpbFMDgI0AjYoN7ofIc/ko2a1rYrdCC7pHYEr2HmzEDciDMZbB
         1iI0wHk9nHTTxjJKMcybsOnRSfx2qR2sJiq/xPJxMicax9REhD1iV/KDzESr6lXu3Bs9
         Sr/anJW3t/njMXfM5/fwuJvNkCQVokyTZjwM2aFdK3jXrC62F1aHMYvyHxOczQr4e06k
         fCEVMpv6ADaHL1l8848cXrqExM4zjDiyXi21mJuwDkqRrg0EKf7ybBhTXWMXGU2/9Mla
         6ZdXHJxwJfnskilr9iDv6NEIvxdGOUznaKt95iKXAYM8odepYSLO09iK0nLDHmcIw5I6
         s41w==
X-Forwarded-Encrypted: i=1; AKwUvBxZ07k50Xp9xVWIvLJLchWLtPG2Z6AnbEN4glZyjj5R+b+aX6MWHHNoSQ6k8GQq+gz43mlLHLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8HtAQ9mU4MIPh64l90gzulMH9v3AAUVd8j0xP9L114k9BhZFm
	jEmaEl6hYGO4AIAb//faUuy6IuyUKrzXD/JrDUpO9BDpkjxY+86BrimANgBw5ZeN0b0UkhBxTYA
	m3dZbq3rFABabuF8LEc1D1iwUEBOE2U1qtUHW+uXO4p90vbBGOg4Bwyt3Vg0=
X-Gm-Gg: AYBFou2JJIhREKTzwpFreaMeu0D0NkZKG3ncOqBRRND+vn9kXMrV8KB2VjSJiTbok5Y
	4WuLJ/LmK4qlGQYxr146W+nCxLijJQadv84j0vLZVeLFzZ7ZBYuBd/QPQDaF3rRs8YV205499js
	49MjQ9faUmTMUWP0thsuJOCVFLPF71wTKrRpZ01PzEwu7wXYLu+rG850jPaakYCgawvVvyCyUuK
	Lws4bN37qrjH+HJC2eAMaZ2n/OMc8566mh1vcWoFnWgdrojUGK2ljN6YLXSG0vb8eW30Ik1YtsB
	1zEMIoKS0mIeSdNx6J+Z8V+en9h8sxwmo6SbpvpPPKs6Zzl7UWN1aGCyghx03CVjxugARtwDE53
	0wPKsUtsk4oEoqVhBTm+yvK+Fqtw=
X-Received: by 2002:a05:620a:7102:b0:93e:f9ba:690f with SMTP id af79cd13be357-93f6fa01641mr287676485a.73.1792741724677;
        Fri, 23 Oct 2026 00:48:44 -0700 (PDT)
X-Received: by 2002:a05:620a:7102:b0:93e:f9ba:690f with SMTP id af79cd13be357-93f6fa01641mr287674585a.73.1792741724211;
        Fri, 23 Oct 2026 00:48:44 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025c67sm3116633f8f.20.2026.10.23.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:48:43 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] gpiolib: don't report -ENOMEM for a requested line without a label
Date: Fri, 23 Oct 2026 09:48:41 +0200
Message-ID: <179274171913.5027.9030259966354597736.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022083343.3905973-3-aambrozewicz@nvidia.com>
References: <20261022083343.3905973-3-aambrozewicz@nvidia.com>
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
X-Proofpoint-ORIG-GUID: ioCOYsSOwzdpLtFnpSF3VB8c5SwObE4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMCBTYWx0ZWRfXwpICD1oscM9+
 rm0Gx+Cd5hF/3AoSn0ProjzrwMoqA+R14/opgcpVn6FNIWb92Kqq5FR+uTRjXW7XsI01uNSdsYJ
 9mEaCnzl0OlnpsAJHW1ZJgy16d6MlbTOZMKJtDF2AvfX9rn+i1rnAzrSU2lA5Z9pYuSP8HH1HYS
 sxapwDpCioT6CYlzGNT9WYxYoZSypiZriDP3gYv68ZQoe9NuDNGv7c1DKmMQYiRpjASON4wMugL
 DGvReq/SCiJ4wdVp/Q1pepaC1rTJ0Uc/fgV9gCFtFBmLmjvj9NUFGvQXqus7NkBpZl5S6SYePL/
 wtoTw8Jexyo4s/Ht1nhmdugNOwTtfmZgS602DAFsRlAn6uNYRAIMXKL34YszUpec63wmBpdRxuS
 audQy7zmQwKYJy140egCEvvCaYb6DGerecSzYFA3wTjfzm0P1JRSDbFOouNPQr49F4yVgCFqOqp
 WEYMDb7K84vNvH/JHrA==
X-Proofpoint-GUID: ioCOYsSOwzdpLtFnpSF3VB8c5SwObE4-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMCBTYWx0ZWRfX6WaDWiWVhDxY
 2qTGTDj8+VQ2YASa1Sck2/6lEreHKYl7ngMFduIaBDKWccJ280X/yLQKBEIOcLqXpIdXMH/HuAI
 C2Ok4ULnw6wHkGMnhbaTtDFj/c2sKTs=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb115d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7ofs3B3pnvE7NeEcutwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230030


On Thu, 22 Oct 2026 11:33:44 +0300, Adrian Ambrozewicz wrote:
> gpiod_request_commit() sets GPIOD_FLAG_REQUESTED, calls ->request() and
> only then sets the label. A line in between has no label, so
> gpiochip_dup_line_label() passes NULL to kstrdup() and returns
> ERR_PTR(-ENOMEM), which for_each_hwgpio() then passes to kfree():
> 
>   BUG: unable to handle page fault for address: ffcc73074355ffc8
>   Call Trace:
>    gpio_sim_dbg_show
>    gpiolib_seq_show
>    seq_read_iter
> 
> [...]

Applied, thanks!

[1/1] gpiolib: don't report -ENOMEM for a requested line without a label
      https://git.kernel.org/brgl/c/dae739137441667d67fbfcc4d303a0ecc6618662

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
