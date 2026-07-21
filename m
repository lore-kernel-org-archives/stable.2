Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369542EEB8
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621732; cv=none; b=QpHjB03Pz6UEK0uEcqi+n2/55aUGeDJMqOBXh2x1XUE5RgRYtbLQQ7xmyRTjV77X6210PlE+4gpaoASXCret0EDQu7jp0UHEvvEP5qQea86YBR+liRGJPFnEWSxW4yRgHULaZjvIaamUR0BLEyAdpSEjxa3BTrEczRuh9sYjDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621732; c=relaxed/simple;
	bh=CRdVeN4q0KGLes1JkHA0OBje7AHMlepcrpKUhlzWorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLwuLgeVewi5zxmC4a0iXjOwBmP3ao7j1uXu30B1SzdRzRu0NjHjzS9izChfOGZcvbn6yNm3nANrI4hokziinJMA7AcJyWOEkuIKKeWRh5QhBsvmgQqxxT1Wr+LkS1RBXc3MXm2nbZYvwAM4aTOs1/K+skDVCYWJraVDvEHIelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jFE0cpdj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jFE0cpdj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDDIf3554522;
	Tue, 21 Jul 2026 08:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AeJI+J
	NylrIZtFfXY4Awdjghv9SPdLiivbZZVmjkiBg=; b=jFE0cpdjVDZVeRBgY++VGE
	vtJNSajLaOFl1hbmaaB2hX+1m7EQCBYVJcv7qZX2LA0sqnNyFgshTzfgiDVWhcxX
	svv/EPHyyLe5UqJUZleOYXxT6r/JWVWMhDdSJTA3CzbLxuJIkDgz+XlPozXaXyYF
	TK09XDJ7IGZLnhg5nBaAhu4lRpKkPqr58jD8Qsom6mGJOvdmHn5+zdAzxMET0eBP
	cjzbSXg92TzSZfqbYw/+poveHQGs7IV2GWw53EPvUpCJX5ktYdcGrLPw5v9gn2iL
	+TBGb0N1Cw3JDhPOw8l+4/1dLc7cbMPrFKSos5pmsiohLMrS/5Ii3WiPDUB6weUA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abbjub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84b7Z016890;
	Tue, 21 Jul 2026 08:15:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq1jsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8F6Tb51708246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E4242005A;
	Tue, 21 Jul 2026 08:15:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D702004E;
	Tue, 21 Jul 2026 08:15:04 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
Date: Tue, 21 Jul 2026 13:45:03 +0530
Message-ID: <178462153938.1974055.13213303810865302248.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615233729.29386-1-enelsonmoore@gmail.com>
References: <20260615233729.29386-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXyrcpP1GGoApC
 suslpr2WMRqACDlViCQfTXQqT8jsNYGxgHw/Q7tdGBzSA0E/UrJfpE0KJEBfTEFYSmOBS6NEERS
 d71BI6Zrc6En3NvLQQykICzuy0gH3rip98xyMw8/CNwci3Pe+QTjzZ+PxBuCMrAQflZX1TqPrVN
 BQucd+cR5OCXoFBrgawHZkptCJd8Z75JuU0DF7vo7ry8An6EKEBCf9BiQNkVbughNbKk4MkZYE6
 X5hXjqb3KCfGBKJM/8PAiacJxwkQxivzUvagZa5O/dWc5+wr5z54V7GwGDAExTho+cObMz3NI6b
 kxHb3Vx5+EnCeRK0H6DBkzs6Hedwy6k7Ffh856vQwXKPVe1OB1O+Jh4ORhAD1J5h7E1MP1AYeH8
 0its2LAtEZt+VKYtEvFI4H4bkRlWAfFysh/10CcuMcAs8NMTHU1g+1UkDedlWnzdk0V6cnwbp7S
 /anRcWsH66oOQt57nmw==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5f2a8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Z59ShqV6-iyD_9e8NWYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 8-kJeEgXvO4PnAtaqHkJ_phIhchJhFVq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX8vJK5+FBirev
 hXN41a1LIhPfCRBAhT0Fvm26/t8T/77y+EZtEvC9lXEDFQuxJ7V2v6SIR6Obtw0cTMVGleqYvfc
 U3CIi7tc0nNFFFR3bknFl5/0C5ChUP8=
X-Proofpoint-GUID: ooLQYhrj8PIKRM93jo5HThky_M-U36xQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Mon, 15 Jun 2026 16:37:26 -0700, Ethan Nelson-Moore wrote:
> mask_user_address() incorrectly checks for CONFIG_E500 instead of
> CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
> E500 hardware. Fix the check to use the correct name.
> 
> Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> Cc: stable@vger.kernel.org # 7.0+
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
      https://git.kernel.org/powerpc/c/d610d3ab18197d87618da11ec5fe8b3cebf32208

cheers
