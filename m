Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281493;
	b=No343gHMquILXOet/JJkraTj8CrZTRzc5dxkBRaIDw7+PAXz2tL677TLjbphcsabqFni
	 ZBF9FwjiCIpliizWv86zF8faFbuxmS1R0yQwSe7wGODU/r+IEY1WsxtC3itqDAEl/ZOsz
	 c7cTwqoAY90uiE5NKdirvyhs7FCo57UqG9mWbOJWoIjAYBr+5emvWiuihvFHTbIWK1iD6
	 oZ5XlBqQ17GgaxB6vfdeyBeof4EFFSeqKTdUlDaXqg9OdKf6NIoDtWF86P/2NMYWv6Cub
	 sxxBMoCtt1bCP0SromhrNxi9bCLO7YMQwCBAK2BZRvZJ5VemUA8745IIqvl9v4wV9zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=03VTQUvtN+Jv+TFLhgycleO7JIZPD71MArYB34m/8/0=;
	b=VVQZG6A2bXcLC6y0uaJMRamzpRzw25i0QqD9lX1HIMhTmZJHSyC0pdbh192nBVob/oGB
	 5nmTk4Zfaz2vzBI2+phlxJiTdAe59Upk6dEWzVhOUSDWitR+mQCdek17H7SBypzMoIdpN
	 ypqDyyrgH0NloTXrlAo6wiJrc4vRdH75UevcW654I3ACz9vzpXkG6Bs5gtpmHGfOFwRD2
	 0JBa/vjIVb9PlfUCdmxnadC5RCC9ahCMcCJuO0dW9wqBdURgne8odxzyLoSjhaKq2s5OA
	 ltjHf7j12PqkkRd1V/0ngwfbAtg4CKrU9209frs91cH9s5XEXL5kzdNsmCJnUHDkbgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abc2+r3t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEtsQyEQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F4606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 17:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0F4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abc2+r3t;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEtsQyEQ
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFa1mY3431242
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 17:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=03VTQUvtN+Jv+TFLhgycleO7
	JIZPD71MArYB34m/8/0=; b=abc2+r3tcdLKrXCqaPyBRnh06SBQTSCrC9mVPVED
	/UipiJc2XVtXNXRza1BfPueE5+t1TmX3lvTLfA+EzNV0UIWlPJQsZN6l/BtXzGwL
	tSwBlN3STr79yK/OY980zUhIgQbkXbEQ+itiz3ZYP09ChWFGiOxcIEOHqnAz6+vR
	ElRjN11JGN5dK/0mj+blp5aqe+ILtjw/m4ITVT3hm0q3XujT9tHV5UxLRhaULzK6
	bkGXVgQU6NrtqdGOTyn+yeKIKfC1Fsz5BHvVrDnje88/+dyDcOkdTwOXY2ThZliC
	fYnOyo+MjLIrcVVpZz577yHycu0zZg9cmOPrTIMvXJMztA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34fk1erv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 17:18:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2373e9b4so227853985a.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795281491; x=1795886291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03VTQUvtN+Jv+TFLhgycleO7JIZPD71MArYB34m/8/0=;
        b=iEtsQyEQ1El8/D/GwdKuoN9X5SiszsQQHe/v5QoMOB7MAdIjR9PXOFVZa9Ewd8Uurv
         5wFk5bzB7058DOkCrf8TpBK2Z8Hi95aFH9X8R5TEJA26uz5ikqeQyMMudpZa6ulsKmqZ
         M1ki4Mxq+UN6RDVCXJr4eh/zL4+pZbiV2W3AQ8b/iwoaSyTfrPlJsXyHDwmOWoKmCq79
         gx88fkajCQjNTSXuXPdn9zvSCJKXls5kY+BnT0Cf53hgctNeGYXXtocfv6mA/7rZJyv1
         eIvhLDhYsz+nmdBoFu3Xs5IL0wymD8K8h5V7cMelpDvk0FevG2Kc0aejUciBLWdyaYp/
         Dufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281491; x=1795886291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03VTQUvtN+Jv+TFLhgycleO7JIZPD71MArYB34m/8/0=;
        b=tgDxjvBI2T/PSwwN9r/BaFuS2a2plv1wsOMBdjvfOkhCnb7Es/x7srQ76lFND4NpaA
         vXfMwzeGTnc7oMSpR2qOo3rHIvkmQIr7mLFl64Hf2tLSmq1s+M2O0/CFra+Y8zosPI9h
         tXkQvt1mGGFJ5/ZK/oTuuoFYTMCNZY3v87Ud7agI11DGpBTgLNLWeGU/eZGdvZCwgecU
         hDbps7Ka0d3ClNeBmAZzJnXgjcnvAWERL7FVAR+90CpVA2QvJEyPlyQyY2L0qbqqpi2f
         GT5XXT/hOZo4/qAXLQQ6AQbISTOoWhEKJ7qss1ejghNDn3sT3B3uhHmiv6L6PSjVvAhV
         V+qA==
X-Forwarded-Encrypted: i=1; AL+hErHihtRU4KnSsKNSnIJB00rxpXUIlc+8El5nFTzMJJg11SFQ4Beod+zmdW61krZ1wq+r1MaUIuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YlK2W2t1oN30XwA5GrPDSGC9jxmefBScma9KyH8huNvRWDygT
	AlXtPFNdQTjOLIXj/jX1Ntl9ZeFPOx8vD/JrTIbdWel3kx751etevqhMKQUUMlJdUhsnb2CI/b1
	ZyjpZoSQG9LvyT5jgFKAKfnlmnf/6iNdOCodxv1RRiaKMNrEEUrz1mCWNAjQ=
X-Gm-Gg: AZFdTZdLqaGp2EWo+IK4DtzZ/MhEj9G+/C1D0l/RTnmfBSwkXrQU5IfOsyfMKqBXJ9U
	+Dp0SIv+g9rJ/ZjpDruNZHxnE9AUMP27DRvfoVYMhDmFq8ul4Iu4IpwnNji+fD6uxwB4m9nSBsK
	4LZ3LIV2kqW1zp6H7NQzXM0TxlZM29nA9dPGfQdHVDx+Cscx+3W8cB5qyWPVS5hI7g4lAK9eEJ9
	Gr/RVMm+R12NrL7egejmYgt5LF2/JlLFqn4p2m9e4UShqirWAr2OtrLLDoGKyA5b7jkd4ZR/z+B
	srIoixOiFnKKrvVAmmfm2Y0INat6uYyF6iBChOAodfzJ/7IS6HYaE+Vja6rOC5TozEr42UVfViu
	wfIWSIEWGgNmWzYC1XJ8IHzIdQMh0TsCfo0n4hxgSFXULaxPLoikq2REBgeBlxJDF
X-Received: by 2002:a05:620a:4443:b0:949:78dc:f90c with SMTP id af79cd13be357-949bab4d991mr1084814285a.60.1795281491272;
        Sat, 21 Nov 2026 09:18:11 -0800 (PST)
X-Received: by 2002:a05:620a:4443:b0:949:78dc:f90c with SMTP id af79cd13be357-949bab4d991mr1084808885a.60.1795281490526;
        Sat, 21 Nov 2026 09:18:10 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm237635335e9.10.2026.11.21.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:18:09 -0800 (PST)
Date: Sat, 21 Nov 2026 19:18:08 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
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
Message-ID: <x5wpvqcrs7xe5hxijyjvoqlkojmwc4eqbw2su6q67ibfmzjvdz@m4kd6gz3iyuh>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
 <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
 <infkyto252rc2ocolww4ihjuptd5xg5qcjtkft7gpyssxhp234@4dnragxtdfxm>
 <20261121-excellent-sociable-limpet-fddb4a@quoll>
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
In-Reply-To: <20261121-excellent-sociable-limpet-fddb4a@quoll>
X-Proofpoint-ORIG-GUID: lFSCGDjQ2a5g3-i2cRekz3iXpIGO1JK8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OCBTYWx0ZWRfX2PrFiJuC52jb
 B5lGDWyOp+7d1qiOmMgGt1ft83FIoB6zBkBFoAHFiB7Wzqg93KwXnw4QCCU4z2i41UDpnumCC8h
 O+vLPONe5i0l5QQhpHZscX/UFD4tUlElBYfROxuzkHPId1456bqKP8QHV2c8xC0JePdGTNC8A+T
 FVusl+lsjXv/6IN8tEMCKcPRrqXTFtROZdQDnpBOPEkyQGp+fJkJcH39mjrvfOB0c2AclnVnVnF
 91LW5BtXW3urm58WiCBNNt9bsFyVv/Dd5ts9PrRLSmaKkcpgl7XKyMdKlxoysm9/t+75KIwvQFx
 HD2Urw/H5vrzygK+D6/s1+x6mdDo4eQcsrmcVydLK7SYqegbp8Gp45imCpORJzxcnQdg2PCUR6V
 b8wuGn+vFnmYXAn8yyNt5ulivpmm4V4JRMpHmPWnlVkDbqzeng+CItmKDaRRNyce8tlcMnSG+xi
 1EPQ+RVtMKqF7krmCzQ==
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6b01d254 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6H0WHjuAAAAA:8 a=AVuSvmmuOnOpfVppq-QA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OCBTYWx0ZWRfX01qbrR+nv4Z9
 W14pI2OQijZefeNe3+WoM/313g24KeTaGQdWY46iMe01wK9aCPolrPesE67AAMh2lCAWbXKNSoX
 P63lMLX8nqDiuQJSqCHXIcidVPDKwXM=
X-Proofpoint-GUID: lFSCGDjQ2a5g3-i2cRekz3iXpIGO1JK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210068

On 26-11-21 11:36:16, Krzysztof Kozlowski wrote:
> On Fri, Nov 20, 2026 at 10:35:27AM +0200, Abel Vesa wrote:
> > On 26-11-19 10:51:25, Griffin Kroah-Hartman wrote:
> > > Update the node for the DW9800K for correctness.
> > > 
> > > Now we correctly select SAC3 mode and enable timing-control with the newly
> > > updated device tree bindings.
> > > 
> > > This is a breaking change for a part that was previously functioning,
> > > but only due to manual register writes in the driver. Now that we have
> > > the correct documentation we are able to update everything to ensure
> > > functionality with other devices using this part.
> > > 
> > > Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> > 
> > With Fixes tag addeed:
> 
> Why? The DTS if backported without drivers, e.g. by other projects,
> would stop working, no?

Hm, I guess you are right. It doesn't fix a functional issue. It only
fixes initial broken design. So no fixes tag then.

Thanks for spotting this.
