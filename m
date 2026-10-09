Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECBE502566
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583684; cv=none; b=oNkXjL2cNuANnbsLB7eKhoKTiqAUSYUguxLzZnmVH9b6fICSozqvcYdnZO9ggR8VCuSY081aFnknPgedbgCto+JercuCEBuU97qjpSm1OIAZeNr+Gwi+eF8UHptzrjLgn/ZGq5O6MWqp6VPon0ajN5ZFjJnJ5G0QEjXBhlzEr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583684; c=relaxed/simple;
	bh=2yDW81GZlx8sHJ+qlyywQjnpRRIPYgvD3dV8GOSohmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iaf97tC9COHMrwKOPHqBxWHv8qPs+oA0XXbIwnpypBeV5zdjvGBXCR4OANTbDSFEEzAzePokEMEI9kWeI+0Bzm43C8UM4XEH+aypnl6GfpPD6KDwHd8mXbnfLm71TvihQzz0HthOw+Z2hq0o2z8i6nIZxXx1pwhfCI2BWHzygxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LrikMMDx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDB6tnar; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LrikMMDx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDB6tnar"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699KhWUl2545286
	for <stable@vger.kernel.org>; Fri, 9 Oct 2026 22:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jot2RFAnsnkeM5kfPFj75St8/mCcz8u7h4DuLJdUQdI=; b=LrikMMDxqlrAhRtJ
	QztnB9LLwVHtvrAZlZq34h0mI910nPUKnbop6irhayiAlj6y7FgUpcFJZpIEvi3A
	oBL9SVqWLyRlgzj3e4HOdajUgTI0Kz1F4Fzgc82S9Vd9Co++SkA6WvAsU8TZTSU5
	yRqN0nEIJIVGmjV+XLuCpZ8WmTyNqT+lvhaAS3zNG8iKq4mk9AXzNqL5I4u55LRx
	E88OM+/gNQqmPsR9A4m7vQVsBXXz+/bTqTIe1o84GPfg4l4iCo5wq8G9YuQfVB//
	K0ujpyfgXiDVXCwRnQovSE1u55vT6/PopMyhZ8XLOpYdWs+K+d4vwMgPGywy4Oui
	dIwwWg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7rvf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Oct 2026 22:08:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso346042eec.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791583681; x=1792188481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jot2RFAnsnkeM5kfPFj75St8/mCcz8u7h4DuLJdUQdI=;
        b=PDB6tnardv/SnkL6XkQHDG3UgcNga4BDMWwVjGwr9Z0NKsdRn+8YlOGeRjYFBIDf4g
         JhKlORvKFungo8XwlX0hepjSH3eHvcIrfBz66hcRmw7OjNml871IxGieFCea0oP8hNyn
         45dV8IkmiaqMpm/RlWg7JxBrteMO7xUmQLzmVWAZm/A84RKD0415rN5j9EM8Hysaem/Y
         Trt52cLA3EC5YXjiw+Pd4eyphfwcaYe9wtar/kENbejsQ5HJHfsbQu+NXCx2wII6fIht
         Aoj338iU+l02/HzjWc0/PAgidLkM7mEvQSIWmLOnkUNbA/oBjvgAKx7mMJGy05MsoLQP
         U8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791583681; x=1792188481;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jot2RFAnsnkeM5kfPFj75St8/mCcz8u7h4DuLJdUQdI=;
        b=ZsRQVKeUAtWuBO+tZMcypzJ1gVkdhHTHluH3iMJReHYLnD0rCD92PYmO8TiqYMHDc0
         FakgfI40DE/swS8fsbrCMNpJ3kgVVoGsyIfEmZRv7IpcKUmrVsk/IqvvgHkjB5MW1Fcs
         Bm3C3dhhyWQ68hHOsn0MfP9rneczNWUAX55TfK7o9L6qW6lWJXq+wKbBMxWHvU4BX8IP
         ONMxaV3F1RfAcCCblriA2fzm4WUPPgPl7htll0rMLlBLRQ6uVPXhf0KP4tmCdhx3Vugv
         Jc4m2rqHJWA5fAnvq90p3ezL6YAbnfQF3CXFLui2Lq2camfK91S07dvdl45mPF27aVrU
         PSGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxchtrbLhSxwTkzoR9FmmVM7OBKcUOeWSWVGdHnNFL23/9tot2bt6jBEeCt/oN+ePO9Ow5QWWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpM808k3WgpPxlLVEf8ZHCmxYydBbJYB+MfxSRNzp7JJWuUZQO
	twZ6yT6kx7phChLDiNuDniQbSj+nipXSXchgrEgkc9oYF601aa5KszY6x24l2iEomyXdN0HRNRH
	puEwkSlVJzsWZjM+iAi4XiCnBBkJnhIH/bioxN0PNYa3qQANxALzmyYAAnMUI8uXLJyU=
X-Gm-Gg: AYBFou0lr4yWKEvaj4gLvHYrO0P5DC/ELjRJwwfQF7/5t8BMQv3BDwhhyU2rpFygUKC
	N/MOnnzhC/4Ptpwet5tKZOjzdqPEXLnlXARVNVUK4880HId8NXbIi12ZF4k6rD4pKBkwjAGCZm/
	0781HF0Hd1DWTLmgJnWkZkkrMpJM9PumnNw81ME+mXh1ou6EJ6QcjMkTJ1tM2vnNOkZvdt6WLZu
	U93gOqWf18UOi51zW5rYKShzVum4QHlsL3iUwZJOCe2wVp/AIJFrmbbHWRZ768R7SX3AOzLtNht
	D0OvQ+CGcDJN3gktjy1xsncc+PA57o6BT2CdUdkO+77jih3DG7layUVU4br8W8NLgMupjIsI156
	nK4SW49dg4f7alXcQKmbwYHJ1Rh5nyPAN7Bw+YJnd+Abtuc6O+5ZovwXwBQ==
X-Received: by 2002:a05:7300:c7cc:b0:351:7dab:58e4 with SMTP id 5a478bee46e88-3537e134b4dmr4228797eec.32.1791583680336;
        Fri, 09 Oct 2026 15:08:00 -0700 (PDT)
X-Received: by 2002:a05:7300:c7cc:b0:351:7dab:58e4 with SMTP id 5a478bee46e88-3537e134b4dmr4228760eec.32.1791583679655;
        Fri, 09 Oct 2026 15:07:59 -0700 (PDT)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm8860018eec.24.2026.10.09.15.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 15:07:58 -0700 (PDT)
Message-ID: <b96945e6-bebe-480b-80ed-d3343e94f2db@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:07:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: initialize CFR locks before capability
 checks
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20261009060326.1162818-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20261009060326.1162818-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4OCBTYWx0ZWRfX3tAwLlL7TVyC
 zjTumn36DKcGI5XRBxIhaWUvghU9bZB5PInFRiN+x9CmiXJSDhgWbubAHDrL+8y10GBI2ZyWSy+
 o5QFaOjd8PKJWdQ5MAEPQac2VRJAOqRtBiO0Hg8pEWEnJr8WmJx664afRlcNwuWBD5LU+nYH217
 tESCHwF1297IxScr17LLpIYwAHv5TAu1Xpn32h1wpQdIjpk5aalb9kSizsjrVR1+1YisBb5llZv
 6Rk53euY6+yUm79emRFNpvAE3jM6/XyN1676DXZ9OUbbiHmQ4qLmAJ6alboB5WvIEuKKciBoEKR
 ZHdodUlb2SAgCOyQgV/A7Xnl46e7lNl9Eiza1/lIGfS3l8Lx2vhbneqkphUM8Z2JkiuUks3Dg5j
 NGAvSFvIZ6fkQ2cwEu2gN8AXHWkVNmIudIDCBzKz3u2jIbxZUIan9rmX0ozaDM071H6xEc1Rwtq
 w+Jpn2uf13j7znG9IUw==
X-Proofpoint-ORIG-GUID: 5gNxdTCzwaj9Txo2HqIKCgsmoNV146C4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4OCBTYWx0ZWRfX4uPCSGgxZhHx
 ejiEa9JFIf2RGUtCdSIR0HaApRpwUl3xJEw6wc30JSLC+TqGRbl7BYwSCqDCUMv+pdMvPvvwDFR
 xTYwaoVZ4lHrl0GK2egjW1VYnRXNRt0=
X-Authority-Analysis: v=2.4 cv=PaFqFShd c=1 sm=1 tr=0 ts=6ac965c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=MAiKVQkammv_BUypPwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 5gNxdTCzwaj9Txo2HqIKCgsmoNV146C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090088

On 10/8/2026 11:03 PM, Runyu Xiao wrote:
> ath11k_cfr_init() returns before initializing cfr->lock when CFR
> capability is absent.  However, station removal still calls
> ath11k_cfr_decrement_peer_count(), which unconditionally takes this
> lock.  This leaves a production path using an uninitialized spinlock.

If this is really happening...

> 
> Initialize cfr->lock for every radio before the capability check.  Keep
> the CFR ring and lookup-table lock initialization conditional, since
> those objects are only used after CFR capability setup.

...then this is a poor solution.

And my review agent agreed:

- Initializing the locks unconditionally at the top of ath11k_cfr_init()
before the early-exit check would work mechanically, but it's wrong
semantically — callers should not need to reason about which subset of struct
fields is safe to use at any given time.

It also ruled out:
- Guarding the call site in mac.c with a capability check would duplicate the
firmware/hw-support logic outside cfr.c, and there could be other callers in
the future.
- Moving the locks to ath11k_ar_init() would be over-engineering; cfr->lock
only protects CFR state.

And concluded:

The fix: guard ath11k_cfr_decrement_peer_count() with cfr->enabled

In cfr.c, add an early return at the top of ath11k_cfr_decrement_peer_count():

void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
                                     struct ath11k_sta *arsta)
{
      struct ath11k_cfr *cfr = &ar->cfr;

      if (!cfr->enabled)
              return;

      spin_lock_bh(&cfr->lock);

      if (arsta->cfr_capture.cfr_enable)
              cfr->cfr_enabled_peer_cnt--;

      spin_unlock_bh(&cfr->lock);
}

Why this is the right approach:

- cfr->enabled is set to true only after spin_lock_init(&cfr->lock) succeeds
and the ring allocation succeeds (cfr.c:997). It stays false in all early-exit
paths: the firmware/hardware capability check at line 959, the
ath11k_dbring_get_cap() failure continue at line 970, and the ring alloc
failure at line 991.
- The check is already used analogously at line 937 in the relay flush path,
so it's an established pattern in this file.
- This avoids touching ath11k_cfr_init() or the call site in mac.c, keeping
the fix minimal and localized to the function that has the precondition.

/jeff
