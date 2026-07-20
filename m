Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340942B723;
	Mon, 20 Jul 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556742; cv=none; b=KWkSgaI+BdgDLWEOzUOXZkuBQFhSoss1Ig9VAp5NUadjwb/008SiZXjIFWEWHc29srmjk13zlE0GcZWB++62Iqn1q5KeOazyQA/kHT1WpdfJcnTeWT1T4R8vLKMnFdK2bt9p2+LAMxtVuVLXb6ckzR+bfxMYFkGoyF74xTQVEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556742; c=relaxed/simple;
	bh=3jWwqtgXHBsY+nVyaeJ11bLFoZhM6a/BfIH8kXVyx/0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=o8TKjLQE0L4ol4flRCFA6wJWadRw44atl/BrObqfs1iB1SxGa42cTg3V4rxlF5DNGpFb9lRA3cwbvZDx+NxoThwLWVQlqdAcSEk/YLmCXnFrktfGllWDUVk43ap1SaQxoTV/WHntTxx3RvtysoialBvuIrTnRnjg0tcqSbWybyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=rBVPRbgy; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="rBVPRbgy"
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDrFoi2987752;
	Mon, 20 Jul 2026 15:12:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=J
	bxx8hw4Eo4sD7QV5xyetGYbpf3+ILqg7Hfp4NhHhtQ=; b=rBVPRbgyvum21AU7g
	5yenIrsDml/ISEyhWhGBcSyiwukNQKfbSqXlG2/YMZpSwoAbfq9Un3v9wM18lAri
	GWkXRTtrjLeIzqjhMGCBTgBSGBkvGJ6AbrW+6DD+wyzK831X3BP+dWU6+tvyYzHD
	JDv3XyGUsjM54vdazi8sMHp4DbKaKWh1T6aUBleaUsZUH8418xt0Us0Lr9j1JQRS
	Kq66xAnUGLyJc1E8NrrPogqWvxQDoSI1XONgnRLt/JC7bXhPltXIv1z/YwhTa36i
	9knLx2tE7QqT3VsutkLndw1z1QxrA/9tY1HuTL4WlZeVlr/zX/aHmLa/a1oSZj7o
	3xj4w==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fhmy1g0dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 15:12:02 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 15:12:00 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Icenowy Zheng <zhengxingda@iscas.ac.cn>
CC: Alessio Belle <Alessio.Belle@imgtec.com>,
        Brajesh Gupta
	<Brajesh.Gupta@imgtec.com>,
        Brendan King <Brendan.King@imgtec.com>,
        "Danilo
 Krummrich" <dakr@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, <stable@vger.kernel.org>
In-Reply-To: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
References: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before
 mapping memory to GPU VM
Message-ID: <178455672087.464601.4204532217928591036.b4-ty@imgtec.com>
Date: Mon, 20 Jul 2026 15:12:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfX0OAw3oYPc5Rw
 43IRIIoaT6rO9wms/dfXv+j2CX2pi/VVE+c5ClFU4T/1u/lEn0AxMVkE6bEhZkJbBc3PcLCC4H/
 z23cUH4xYsGBqHqiw9MGtGx4Zv5z3ow58Fil+HfxXqr37KbIjrl+hx065NVzI7bCtPh4X6rRVRo
 wjbaXzyRVuQqJ1oXaN8hBugC79xNqbFUWo/MJDvowj7arvAGf0HiIpx/Sh8cX6CZsSN+JI9Mgs0
 gIUxnAn0VQwVJMhTwNg1xNaCrxTkNtiTVDgkj9AKNWR2AzZdk/ghdXPeDcjZ9OLol4QkB/L57d+
 LbcwUDbZPowvu/mr198ywD+OU08kLPTHdpQaQRkPgJt5ELpGvvaoVeUAe08rn7DTserWol7Hu7l
 9lM8JhU68DmPOS3bRWNxvIu8o4DuedyKjyFI1+86VvEYKiJs7F0vJ45JdRJ728GYwvIQHsYaqZb
 lNoIQzSX8UAmEi0V1SQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1OCBTYWx0ZWRfX0rAX/3VGIXfv
 gL8LFonlzDnneeTTA03+AeU7srtKmQh6AUbEnqxPzrsZiXFvU+CMxmOfzBVfgz/tglO/vBAbQPF
 65IaaHpS4QPunKxgKlddsVhHo9RvTC0=
X-Proofpoint-GUID: ExdzClEsO37VXwoQp_rL_7X6g2QWAxFv
X-Authority-Analysis: v=2.4 cv=YIevDxGx c=1 sm=1 tr=0 ts=6a5e2cb2 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=CNkhBcH9ogg0Ut-P5gEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: ExdzClEsO37VXwoQp_rL_7X6g2QWAxFv

On Tue, 14 Jul 2026 15:36:41 +0800, Icenowy Zheng wrote:
> The drm gpuvm code doesn't protect find operation against map operation,
> and the driver needs to ensure a map operation shouldn't happen when a
> find operation is in progress.
> 
> In some cases a find operation will be in progress when doing map/unmap
> operations, and the find operation will do a NULL pointer deference.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM
      commit: 17e2030f37600994440f875dc410615d5c66ee6d

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

