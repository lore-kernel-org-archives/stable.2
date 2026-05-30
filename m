Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B7225A38
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148467; cv=none; b=mNiaDx+0gsy2DDi51zZVR0yiZrcx0haw06QpGdl3chVOvL4uq6+o2IeRTnDR+88CfA/jK9kjJQbjqWEJztOdBweuoZXfbglVdlfjAtyKfKW9Jy6MBXjcsaK0694i6vubQafXdzgHF/QI3sGfGshAkrLxqrysAe6fLGigvC9cEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148467; c=relaxed/simple;
	bh=tW2CMdXFT9AuTtzCZ3CRjgagQnl9KlmnYdX4+oulx+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE3pPEmGz5I4dZDT9rosJuCGPAjR31eS42VORWQLjtqDXP3XHJdQ84VsTOeERq+0knorSPNJDdmT55jAkPo7mc0yUqHwLQcGHBcpjcePCEAXR3vrXFKYa8g8SN9g0Vq4lbJxyLMFBCMXPeLLBLRcA5v4uWItJERwYfIG/lw1q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFkajicP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VS8GDcmK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFkajicP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VS8GDcmK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U4egCG2176625
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=; b=oFkajicPppxbRMoW
	fmnP4yKYDPBktloJaWJVH/GYy9qc9kveFQYY5eH8gdk6jCAi1GOiPGXftGq4Gfy3
	Frn1xvgxGYV8lKM4WrMMPlpZtmpqFMfJ4aI4c0X6uqwJq7EVTA0nHcH5j9Vp+6t9
	qvfgHtga0EGd7CRAQYq2cZSAOyXG4QhbyItOkE8lGYJk14x4AdGFAdRdn03tpF4G
	OJRuu7ccsY/aOGgX7F3miGdyGv0hf4thY73sWVq5g2bPsCtdDV6V7ev9tGZ9SJej
	xdI6VicllCs5j46lOgapJmgKT7sA6DHINRFRbee96mGMc4gddLt0fTDqrknIChB8
	EmdA+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs2h8uuf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 30 May 2026 13:41:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso4224031a91.1
        for <stable@vger.kernel.org>; Sat, 30 May 2026 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780148464; x=1780753264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=;
        b=VS8GDcmKyRj9ZS/a6QDKJ+MA660uNhBX3y9mlcifnQaEVF36Ez7c09bIRhQ8kewuXN
         yY7jG3RhrIEcWfEFADpnVBSdT4oIL6RCaZpm4OtBsQJFIY0lzF1TIgON43Hn+b/O7EY3
         Xw9hs+IERc351dxaUVs6GlP3qrzYQxIsYVUybx0Ski1jdIYH63LXmhFAIEQ+ogmWdQpD
         x9RYT4OMAblVytrzi/m46c9G8wW1VCwd67+4PGElFyle6nWOE/oq1GtJbBZ7yfwcqbJJ
         iOIR1L7I9TlCwIy2NgJogQjp9+ium1BKc7a1kPDv1r5Sa0CGcTScwDRI0/QJWCb+F+fl
         byeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780148464; x=1780753264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=;
        b=T67JZNaf75ktuhNCoeraQ81I4BQ/DdB6dBIvTIHa6lQafjOPl6JQAKpQ+fBYjb4b0w
         OdkNnW+wV6Aka2BPtyd2N7GcwXTQBGWnKjLcO99Es1wqr8XFbLyIVO9F8IVarVOnph3b
         fZHrrAnbS4RZrax7yFPWcMMhr7ZDrpbQ94UkfInfCDfIHc/z4lNJpKt08PY8m9/sBkRt
         zY7Zi8yDZgnKBHkUGaTB/vL9Rkti31Pi6MVje4ovBafQYDdr9OTwzwU3u7X0hSNVeygT
         yYzX0OB3GJK/niU98BEqAfDBtGv2LH4ZoR/3o6uqiSbPnKhTAirw8xKPmKAcYmsYszpi
         X/oQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+PpXGRhp2zFigeMUOfLyLbLeJJEHszy7L/uohvfLN4BU2zbtzyLihkEHfhm5ekWFAnBBSteQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMPei+2zhvvwLTG/KgeVKUSJ7l1okw/7+JYuUdiboybYUx0l8
	XV6OL6cq60Jqp9NgRTxZ9qBsFwWGQ+6yyeMsKt8CYRayD0YNC9BfOXzZE8SCokCAq9eHRk1GEax
	5QlGa0hCTJAsI0Gytfp+eM1XBKb4s/lD6/TZv8rWeyteikyzHmLM9TMFhDaM=
X-Gm-Gg: Acq92OFCdqekRlPBgz4KV83DywuFTK54wowRw5Srs1wQVmGnfqfXvMJ69FYW/xDHfmK
	oKmgqVh0XbmgMMJsWfYt7bivFm2BCXn1qa0nR6G2gOrH4Zpo9rOl4uahrBPi4nECXCt92ijqR2Y
	CF1UwVIUok/KmtHuGtf/OCBDmguOtLsS1FbWDttIGWCeiXTiMPAZF46stCYjGDkxtNQQg2Vxtsm
	Zr+n9yAa1N7/tPzuM/gBBoC7N0e/gppzFAHBl9ZJmAWJAAFDDVL9kjPTGig5Ly2z4cit4x9FuGY
	kq8GA5MxKv6InXLop1uKRAAg82eCpZR4K80wawReY/FPhFD+4PS/zupjkgVFL09Dl4B5P28MMAg
	NEhVvgtkvIFW+aI2CQmYhLqdSzxKhRBxqwyKf9R8oHhT9qoNLUBFR/MSdGAqc/8vu5vWxR3mjih
	2m2Un16lmd9hnU8Ns5XaZmHsuy7gA=
X-Received: by 2002:a17:90b:28c3:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-36c4ff34042mr3494606a91.9.1780148464569;
        Sat, 30 May 2026 06:41:04 -0700 (PDT)
X-Received: by 2002:a17:90b:28c3:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-36c4ff34042mr3494579a91.9.1780148463920;
        Sat, 30 May 2026 06:41:03 -0700 (PDT)
Received: from [10.133.33.29] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc9831csm6617531a91.1.2026.05.30.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 06:41:03 -0700 (PDT)
Message-ID: <1ba14321-bea9-4fdd-9f8e-87e31d034de8@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:40:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
        stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260530095809.213611-1-ojeda@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE0NiBTYWx0ZWRfX97yDNrFM/Y4S
 qoFqIRq1oNcFGsvy0EOZxCG4TIvtZmbGqDgbsQVSKLkx5OkWkLIjT4KB5XwUIP+botDWjIdnFot
 m8E/qqNh3aC4EdFaWYM7HdK31ptgbaHgvIBpHpgplIlctKHjrOW8BUEkzoBvhY3Ot7bOX977ZzN
 iM9oeWCnGLMb/QEnOGmsAFrYKLXqrq/8L8Qj4+j1+J+F5EZYhu9E/YfQtYxRhHM45t0xs2BYopB
 RZhOeZ0tGquljtFYdR2G7VTZPvqg8h8cf27afijjscixYqKXj21irnGpXze4H8Gghg4VqoyQxPT
 y3JzY1V/CrXaC2uoPmPt8tx1f6dTcunTx/4MAB751fuv5IhDgGhAJvsfRX1M8b0zWnklvxEpVFB
 oN0U52AUNEvkU0out1BHHTNvok7kUplOFR+/fG9sa/47panjPqZ6E2DGLQc3ESYyTQe7pwDKu3g
 CCgtIVtxepHcXln81Ew==
X-Proofpoint-ORIG-GUID: -4iSHwLJO6nfREO9IJSrwmh27Qrv0AuS
X-Proofpoint-GUID: -4iSHwLJO6nfREO9IJSrwmh27Qrv0AuS
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a1ae8f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=R22tBeTbAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BzWTF2Su1jj-Cm_4THoA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=71pCXManv-pOE82v44e3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300146

On 5/30/2026 5:58 PM, Miguel Ojeda wrote:
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
> 
>      warning: expression can be simplified using `Result::unwrap_or()`
>          --> rust/kernel/cpufreq.rs:1326:60
>           |
>      1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
>           |                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           |
>           = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#map_or_identity
>           = note: `-W clippy::map-or-identity` implied by `-W clippy::all`
>           = help: to override `-W clippy::all` add `#[allow(clippy::map_or_identity)]`
>      help: consider using `unwrap_or`
>           |
>      1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
>      1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
>           |
> 
> The suggestion is valid, thus clean it up.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   rust/kernel/cpufreq.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index d8d26870bea2..a20bd5006f38 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1323,7 +1323,7 @@ impl<T: Driver> Registration<T> {
>           // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
>           let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
>   
> -        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
> +        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
>       }
>   
>       /// Driver's `update_limit` callback.
> 
> base-commit: 420dd187e1572bb7e232781bc4377a80c8eb64fb


-- 
Thx and BRs,
Zhongqiu Han
