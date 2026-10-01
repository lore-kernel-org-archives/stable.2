Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63696448B84
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841132; cv=none; b=BOyFXPbVKkNGth34vP5UIFCuFA9zlmASIZPS8Y+Xm7UetBB3c6PjTCF4HxelxGL1r2qnumPNwJrqrCMOM/bBJUToMmxoYnXhNAV7FFU6dTAVP6nXaspcia9jb+UA+5VgO0hhhjZZfRJzx6N71UfYsVfDgeEnwwn2h8EzRoaYX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841132; c=relaxed/simple;
	bh=E7FlCPW99o64hLROxUlikKTNWxVAx7oj4/lwKHXZSQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsXUrv2kCvFvjY20X3Q39jbARVClj+0N+OolO2uNHj1td6RwbKCLkYwa0LWSfrCTsZjugQ6r3McQTdiL2YwCWofWNL0oabe/fIyijmF41Tx5efyIAeNb+UZ0n7bzRggEVHAcyntygF5lzbd3QCdvTXzWtDECEe3mdo+cuDmVheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYRgZ13V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V9xLokL+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYRgZ13V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V9xLokL+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xmad1661092
	for <stable@vger.kernel.org>; Thu, 1 Oct 2026 07:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=; b=JYRgZ13VyVmbwDrX
	AG6zA1wKAbuGJAJkyka85eqfX33Amquk2woYcoQL4w3dWTcWtuX0PyTPfYnVv+YD
	ajUQmExbX7NlZF/puxKb3X+iudHwVddaD52CHiZueoqerXK49mv12zBmYkVR4EU9
	daten3a5sr43hqaKBrLsIZEtaV2NnS4wWgOpQY2wJaYoVf94D+5dOVuhaoB4mLnY
	QWZGNcCWtOB85A4qkK/1x7zA4gpaZpZo/UmlTATjrbWLCcWO7WQy1IYpo1vv6bto
	3kZ+wDvviwu5hSvCFBbxSdyGXxWVfFLe9Ip4CeOLUT2RDBzK2A6LVEWk1QkBXwga
	oQa/lg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pk4pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:52:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so1202080385a.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790841129; x=1791445929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=;
        b=V9xLokL+apg/VIN8thTgPkmFMoq3s2DE0Kn8EH88Xt1DHeOx1t6YEV28GSk2XOyHfP
         vyB010cgZ6Xezw32cKverEExJAemRouudbHKCDdT1rbYyihUUhl+0+/oS8/zjSI/3/Fb
         cc+OhovoiIiftaL+t2xCEflTnha2l7smHJbLRkURm2ZdQxwwyhIwEyJLcydCfcoi69MU
         LgYtiIgOVMbtie4EM/fGiwauE28PZZrVAbjIEW+Xzqd/tfQhEv0JlfjDLSI2EUM+e8k4
         7UBgPQgP0cwe3dDdCvihvR4gz2ecbOr70tHoFu1ehcFDr5zzhAmZdz5CJSUWT1OWgig3
         V8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841129; x=1791445929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=;
        b=BYHVR7bcGec5fO60RZwNQPCFs14voNZxJNXTirFcSBvVfkzYJfOS8f1+kd4NQLCVyP
         q+6/XWjW6ZZCEvEfgmsQT9ZSKfmUKEexTD1v5mblLJlVRqirZpqbhzaVswOcBDNSG7N8
         d66n1QunyrBdaCRzKyvctElXoPLyw7nvvwXHMWhS4CJw1JlIEfll+VTWzmsYxe2raRLp
         Yfk3w7Tjn4MGJzU6s76rXAMZasf9/Ms6nbuCBSsRd4V9m8Zyacr6fVVkr1w6tmy0EiLm
         kVvvLGHPG19L+Ie11PWiylbudm9loGdu4Lx8HK9VY+A58rFEDTwT18PNFdw+QWMhJp8J
         0i1g==
X-Forwarded-Encrypted: i=1; AKwUvByKVTEVUJWVEdWS6C5ftuYWnS5KeBURBTY9PzTURh1hnuFy04b17OSArpht5783RBe0zwjvqcY=@vger.kernel.org
X-Gm-Message-State: AFuF++mMaliyiHuO28ZOYuOGH7RFVP7bdLV77i992fnXDTyUCJPY57qe
	rBWhqNb8e12hVZa0SCfzKiBdV+R5ltKL3HVzSYzS6Z/Z5grO8ScWoHUg3s1qmwbrIPFY4lPA8Pn
	PpJGZ/DqVD7YSBN8dH7+4K51WwelVjCdRPPk6hEPkrm7Y7h9vUTfkEJYtlcY=
X-Gm-Gg: AYBFou264F8C05OG1jBP03Jca9+eSJcJ83J+4z0thYIO4Dn0iu8094uYPTdMjcKAXVj
	BUxMp9bBz7pdUxxJYdCs7QfWPDaHWLIrsYKf03kCSgYutDFggZg5b/Ku+aPEu84d1SDVzk/tZt5
	0SGlkGx/oXipblho4LfSaiWO4Z44dAFxHoOehi4tHBktm2vu3lFbc+O8awLTrCSdcF2PQyeLdL/
	cY7hlx9FuhpPtVdXwfvB3kR3aHy8Hq9SytVZFni40QFfWXop8XlQeRrMbc3ukd9OzsvKzktwUuL
	qc4Nt2VTTwH7xyu+WdFGsQm/BKdnU0q21kpkhzHX7xmMlhkLCzLT7vb8QoYkg86835d/h4h+4i3
	ZpSNgdr170fX9sSqCIdj9ePWEulU=
X-Received: by 2002:a05:620a:294d:b0:93c:61e0:81fb with SMTP id af79cd13be357-93ca97359c2mr745199385a.46.1790841128625;
        Thu, 01 Oct 2026 00:52:08 -0700 (PDT)
X-Received: by 2002:a05:620a:294d:b0:93c:61e0:81fb with SMTP id af79cd13be357-93ca97359c2mr745196185a.46.1790841128192;
        Thu, 01 Oct 2026 00:52:08 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f220sm48915035e9.5.2026.10.01.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:52:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Alexey Charkov <alchark@flipper.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
Date: Thu,  1 Oct 2026 09:52:04 +0200
Message-ID: <179084112209.5187.16060198876692455319.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
References: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2I1988Ft6EIPUv7dkSuQ6wW_6_ovB1Sb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX2+NnN3rexI7N
 +2jFSzyQNsc1XDlyVnKhj8krVAWL+m5M43LfgGphLNm+x7McyK+bRDKVz4cAApIcnoMQ8Jv+5D4
 LlPO9xkfUMSaqTXPkJoJ4tGUG8LJKoI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX5tVOb+d3+0ec
 VHaxtgyCWvfyXnFK/jl31dd409/2K5wVMukk/B3DrRB0tDv/DLBLrItsWuUOuHK3/dbkDPuXB5j
 aIEmLV5GZVsD5TYQ5NIOVjBrTjSFL6gWxjr7hUP2tHxl1LCE98GuQgSViAw1XBp52rKtF/OFcGA
 qQsvBpNTTE+kYP6rdzzUg1NzXUkSuSLVSKhRZlI7XcYNbT9jQqV/RmOwoqof8jGijD9zgePdLxV
 7VREgVbfFCIOyxHA8jTWWfjPhGkACHu2Vb+vBGJ5ENWqXHOOt6s7Qotc16wFN9VJJkQwa1m+0h/
 wIWlzAtEfSbv1a2yO6/3ZC2Y0sVb2Fb5CxMzI4JHbp4IWkPMOsB5Xy3SSgFqzu1ukKHu9gePUSq
 E+drSTlNlz4V92cHLMgUzMXYczxiXfQhwbsm5Bquk7QoLxOKl2jH+qC8Alh2mjl5bplmLeYZi9v
 CwKtx+ahSbBjoQcrVpA==
X-Proofpoint-GUID: 2I1988Ft6EIPUv7dkSuQ6wW_6_ovB1Sb
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe1129 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0LJTc_hIYTHMuy4QETIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010031


On Wed, 30 Sep 2026 20:10:21 +0400, Alexey Charkov wrote:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> pwrseq-pcie-m2.c never did, leading to a memory leak.
> 
> Add an explicit kfree() for the consumers array.
> 
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
      https://git.kernel.org/brgl/c/0d6c5794fd633427f0d4ad8b51d94061295649da

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
