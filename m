Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163733;
	b=iixnwhYbKZFlC8cUUfD9TqA56RBJTAS177jpWDnii8RJaPz2gXke/zDpA8GCuHe1eU28
	 KlDhO9Xz5mXXxho8wG0JGWDxcJ/zz71kNcF58YcP0XJIuEMdusmt6O/E9LWTDicS4ptE5
	 OwH9Xt6N9OclSoj1HicfMPAPCPp8jvhMZ44v0fx3e63D1nWW5J8zRy8hbY9PbW/ThlZlJ
	 UQEoN/Ztul/Zh4uWqNJkqiW4CQ8LE1Va9ZHuPDq3h8q2CtPBwyZKwV/nlXZB6thzjcnkv
	 0DS1YpM6+GRVrMtCcYjhPSCvizHXEh9VDuBpFW9Buzy71RgvQdEhG4E1Yr/FEPFd0NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163733;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hBY5wVTqJ0IzIgFA/9FEwfwpYhXNkAYQbs4g4C/IQNg=;
	b=O/pTp/2CQnJx5cD+vkGfRrCGP6sUceowsY/sQ/G6pjynKMgf3eMTQ84mxBp1vt5tKzWB
	 QAK2m2N81GgL6oYPB8oaAI1v8+bnuI5X5KNJDL/Nwy8Vrie/mmuYcQzwRALyj78JYd19H
	 THeLSEL7SNWD3XvXSOVynnH5N569RqEnPGaG5OJSLIYaTFQ3cQOi+3MfaalKkTytxp6FF
	 ytKqqV4yl1eTtJSfyN+1JPtg3Y2HsjD0yo0/8+2dl2mtbCAbQUnv+pDx9dPy4h5W7pE7Y
	 N3jqI5vHFrsZBf78bKgcVGPLxz0RJ5R1L9kSIAhHegb1TdIpBpubXIrHZRSyd5nWSzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="NZmEE/Xx";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=amV4y0AS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E89606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E89606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZmEE/Xx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=amV4y0AS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fEwv758047
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hBY5wVTqJ0IzIgFA/9FEwfwp
	YhXNkAYQbs4g4C/IQNg=; b=NZmEE/XxcPjqXuV5CWFQxRpFNKE5Jr10PfurHbgU
	FkVtmFV5oC2/TEqkyHAC9uacgbHh/U4gMIyBInbpDvbGxE7Fid4GxDjTDxlfdwn+
	sbaUa6uKJf65NsCo+ldpcI2Rrmxu18X6mzxbpcpjqOu2jEgmicgVkmFViNyinNf4
	Ja4ek4DWVwvopZzZA++XTY6q4ldMaQAkHnz0IMR0iCfkMRtAbQgDnerHGpD7dxjP
	7XnahJra3byw2uWD72RvpwDS6F9s4AFcdv7ApjQ5OqsY0ASKBJphlDt3D3bmXQRl
	Y6N4V0f4gzDoOmjep1s/K9FH50bTHk/fRNWHUJqQFf3PHA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5trtg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:35:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495c71055bso155714785a.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795163730; x=1795768530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hBY5wVTqJ0IzIgFA/9FEwfwpYhXNkAYQbs4g4C/IQNg=;
        b=amV4y0ASfS35BwlYJQE6/A7xxWoWhZOUitXbA9gtgENnAYfrwzxj4JZqqwQf5d7nnD
         Dj6dwh/bdlXVMkvzEAtxKbidxvBbbO1JNtOPa0nUvj9o7Ip4C0s4FPT7BYOJel2+cWOv
         yng6nFGD3ZkAb1FsUW7wjW3gOOPZCv9AaYsLVAw+kzZkmYy+1MN9v+QKhgUVTpwcbw+S
         gBgJ9wojqeSU5bWY6GNckJ4XwVNRkBJMd/gDJpiaS5B3Gu7gRosf6uPbFlMV0Nxd345L
         emPKwpIgtQ/OLQnwfuWCCo30q2fxPGC8nwP1VEE0H+4xjZxFT57NZklQAnSsRud+0vmn
         +yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163730; x=1795768530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBY5wVTqJ0IzIgFA/9FEwfwpYhXNkAYQbs4g4C/IQNg=;
        b=ZB5QK7M7SsKSzXx2vcxQzm5W+r7jguPNev8ndXgNSAOlRjM8molaCUThDwvhx8nzEA
         MFpuelugreQpqi0bi9j3QcyLF6KH0AWJMTZR1W9/HYu6YSLGvMhqqE1+QGl7Gp66ehe4
         LQk/bpiI/H8/XvvlXTAe79TFpPpzEocIlRvXX6tNv2A2LDYhKgRfUeaWjO6T9O6RWwMT
         QgYPNIthoU3ENEE2j3+nlzv5IHzeVMheGbQCZEMc5Kmz67i/lf+3TibT7JGLk0tYl4Ko
         JWET26phalEgS7KzQctaFjTNwwaS/HHaSZvhWRk1wwnEbD89mgf7YpHDeMGz/TYLSS0R
         sc7g==
X-Forwarded-Encrypted: i=1; AL+hErGkETvaGBM9+H8vTL2SsnFv/lN3I4Wy70ub9EKrU90Ik90/gDrchk5qsGZSIs3Dno+/+1XuJRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kCtD7VTWuwkPfsU+8yp5A9J9/y8BjK4fNquu4EXNz/++qbVmM
	P3q/GA1e3ZfxKaPSJfbfidczhhrFrNsB+EaaFIi/Zm4iEVyp8RlPReGfugmO0Pual4TrxDpKFS5
	uq70uTzOnmOZugWAu9KcQ7xOhYzj44CHtxZwWT8F9z3jwi+Aaq4vc8i1DoOw=
X-Gm-Gg: AYBFou3oo2VBr/sc+PfNYxU49a8DoLEXJNBPS5+gxd4HDZTRPslXGtmOyZu3JuKgcH/
	dPnK00XdK3GjuI3WXIfVqs5SzHXTSRsT2fICWNd8eQnVC6dOSH5Sm+A8XZ4Rz9D+Xzhlj9hhduT
	LwEFDKH6Zaxfv6lr0AJgQtN9jjYNSrowQZhTjTvK1vqASyUXsCTnQlKkN9+Z0zHIRCYzGMeVD3l
	VTQVnhQjVdjruruFGIogZNsdfpi1CShY8/oziYD1y73Ol21MMsys7Y9BCD5JoEvSn9ygT9H4WwS
	whjhJPQ+xkkaauEmCNoaYP+tcoVClKsT8HSFnsSDPAp0sNEgmN9qCCQuBXHyZ58KKh9Yjevq+Kr
	7hAq3lByUStck0R/Gq+vJ5Avi5+zTh0tRsyaOoZNbliKdz+E1M+GohVj7Gm0w6MhS
X-Received: by 2002:a05:620a:4443:b0:949:7118:47e3 with SMTP id af79cd13be357-949bab4d96fmr378869385a.58.1795163730228;
        Fri, 20 Nov 2026 00:35:30 -0800 (PST)
X-Received: by 2002:a05:620a:4443:b0:949:7118:47e3 with SMTP id af79cd13be357-949bab4d96fmr378864785a.58.1795163729507;
        Fri, 20 Nov 2026 00:35:29 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm3967531f8f.42.2026.11.20.00.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:35:28 -0800 (PST)
Date: Fri, 20 Nov 2026 10:35:27 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Fix
 DW9800K support
Message-ID: <infkyto252rc2ocolww4ihjuptd5xg5qcjtkft7gpyssxhp234@4dnragxtdfxm>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX7OsIipegoDxD
 7xm2pT84HXgEvz4DS3oznyl1pGjJ8jpy6dY6ByIiPPkgo3i45ToyWBUrOnqOozjmaaylE0ZnsMP
 RAbgyP6WkrVMm2yn/AO8laREv45Dpvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX+VKzKKFUWFQV
 2DshNr4uT2KpBy2BH3cyUBf6uMkev6ur3hDWmPm6nOWpJGpaOKMyvNsQo66QFR8DGLb4SQGbwMK
 aKWDXUVc+gVvdkctTfRpgjBtQqjQlYbSJg9mj1mbJNIu3jomnnzOpzPnQvk6hGW7xei0JhV2hA8
 vMxiE01sMLviPJSekAhPQjLZ2D3NR2wQw0GsZ52xg8uoiWi1GRTJ8cPYI73ZFQ7wTtne/FOAr6f
 CN10QUgwMZAlB7K4oV+D0W2FibPv0cLMtRMpLPogZxBSb3vR11c4ukUM0ZvhjtnikdKXjGf/sz9
 I6ngIMXQmIJItdJwj1cYVoGo7KW61d+eXxoHqzfrCN7q0Gu5rvVMEGbKJsnuZ7FGtk24Ljdj4EC
 greohCEgty0ApsSe1U2F2wtnQNeffHrT+51nI+G9agoRsLYUDVX0yUmKMIp6VfiM2DkIYVWReXN
 UeTjnAYp3Aeoz9slnTA==
X-Proofpoint-GUID: nAdex-RQgQ2o0zyvXr62oOEqjBOyb6Pf
X-Proofpoint-ORIG-GUID: nAdex-RQgQ2o0zyvXr62oOEqjBOyb6Pf
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b000653 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=YOuP2q-gqnfq9OsU_fgA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200033

On 26-11-19 10:51:25, Griffin Kroah-Hartman wrote:
> Update the node for the DW9800K for correctness.
> 
> Now we correctly select SAC3 mode and enable timing-control with the newly
> updated device tree bindings.
> 
> This is a breaking change for a part that was previously functioning,
> but only due to manual register writes in the driver. Now that we have
> the correct documentation we are able to update everything to ensure
> functionality with other devices using this part.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

With Fixes tag addeed:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
