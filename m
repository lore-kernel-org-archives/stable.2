Received: from mx0b-00617f01.pphosted.com (mx0b-00617f01.pphosted.com [205.220.177.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1B4BEE37
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387055; cv=none; b=k1y47wLc1OacqD12wzdjx0cpmIaPGpj36PvU82mLReSzcjlGXRKN5wCnkjNysNV4COIHh3E0WPmE+vrOo0hQKeFt56EIJhmctDkgJCDBbe4eOyraOhT5l1fGaYMd7dIlzgkOqe0mOB4gSu4CA6ifHSnWQrmxBC5DOCvnCTLXXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387055; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyLIKkYfPgkzK9LeydOEZpeqTGValf8p7VIJKFml2MtALgGe1TOIP5uz9utM0FGaNhNA0s73siWC3bnkBRPrx0uoX+AJubZ9ulmftOcLHa4ck36I44V76h8xoqCTuSBzqilm3eDKQrY+2m2EvbEOiQx1ewMdVntA9GMZJ+O3kgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.177.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247528.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697EwXAF1235183
	for <stable@vger.kernel.org>; Wed, 7 Oct 2026 11:30:46 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5pxngdbx-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:30:45 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Wed, 7 Oct
 2026 09:48:48 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Wed, 7 Oct 2026 09:48:44 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <stable@vger.kernel.org>
Subject: fund transfer opportunity,Reply)
Date: Wed, 7 Oct 2026 15:48:40 +0200
Message-ID: <20261007154840.D556B67F65DA146E@psmicorp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MSBTYWx0ZWRfXz5B8/Dn1X1TK
 YhVwB3iBi3GaC8dMyziiKhpgWdwMZbcxVpjoTKvfv1zXwEJzTb/Psc5Su4hLsYpLfGnup2ynyx3
 tO103TLfpIMJE6DwPYZ/RyD0MN6hY4pO0DFf1GG8JcHEJesCMERtwpmN7joAUsRlf0ybQ6/cZYi
 RPzCp79fe3RzUK6be+6ugFs2ThBMV5OwVtsxSnXzrt7CpP1k1J0WWhFfdLfZePsoyv+yGvajbsd
 aK3oI2x000Pqyu39nuDYoaPu636qIN0ydH5tRVqrsIO0rB6xCmKCskvHcFQpTqO92cmhoy5Eh/Z
 iRTWlaZAQR/g/wbbLKb1sqzNR4KIQ1X2k8933k8lcT3gQ1jY2NJZ6uXnevcJ9eDaehvK8g7NmXH
 QyvBkO+71U4Xtr6AgIOoAJ4hFK0C1JxqmADjvSxQbQaz2VxYlq5mR76AySivCDzwWY2kl+ZKXA9
 wtbRgPhaJmWXSlEeWYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MSBTYWx0ZWRfX/Vv4mhaXe0ns
 9OJvtA+hum6VMh0UzRfPyNE2qqpCD0Viam8+gn43xB+nG4R7bMcft2frjsRXASbZ2PHtmIjuGz1
 Miuzdl98CD8Yy9lzRXXgQ251WcebO3z7Iz62OiN6qAoHyb5iWRmf
X-Proofpoint-GUID: LlIxEfeYtjgVbOhn4PJslx4hGu3zNEhP
X-Proofpoint-ORIG-GUID: LlIxEfeYtjgVbOhn4PJslx4hGu3zNEhP
X-Authority-Analysis: v=2.4 cv=Vf1ir1p9 c=1 sm=1 tr=0 ts=6ac665a5 cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=FHnH0SYMNjvGwZk24hmG:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070061

