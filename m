Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE947F794;
	Wed,  2 Sep 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351708; cv=none; b=VTzVQtDoPRFbLxA0BGyuZtud/Qglaz3UgW4U2unRCKMY2RURz9ILPzSv23QCB65r7CoYRKFsehYfLgyadqj0A7POfeIcSd4rlQQPy4LWSxrX3qkYE+mG1Lb6fO+wOkcw2ogDMHhNexvBLyGu/mlPerLKXoS4OG1dR2lL7RT3cEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351708; c=relaxed/simple;
	bh=GGmVS2JaA+qTkb4ZBzBzV0czpxciN7kZWeDdJ0FbVXQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=W88aYpyPB1tj5MJ3T3ifJMTFFgnuwPeSauj2w6vRCmi5gz/hoPorC+4OL9WRVT5rn8/8cscrUcP4uebTU0Rqn6azToM4asEsTp//phE+4nu1MKIdDr9VmTsO++N9GTpCQ2cbo0eCcIL5jb8ThvToeXoThryYslsdfa1yv3ZKQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tOqeyw0Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tOqeyw0Q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829Vbuh3810373;
	Wed, 2 Sep 2026 12:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EmRAOE
	NCn3z/TkdCL3AO3GgcjO7Z7WviRahN4fsbw+s=; b=tOqeyw0QJ0lLZZlqPlkayA
	DT6HOt6X2+nERLzNMk2mQWpf+xwUq9B3gy4Fnvcrs6pDylGX7nsGP/iG41dzVmpM
	Pcowjh6VFU/LhqZRbrK3iDgC+Y8TcZMiJ9KjK+Nn8a6RVOr5fVM1WcMl/t65Rg6C
	nUUXc3362yKIPqbzed+m4bouso7smOJ67v6tpLqnboBIUPtYRHXP4mcMUfS1Yo3x
	EE2pHL8lpAfFZPIKVcNxvPZ8orHslMv2aDd68adX6+VIZUoz0PFmGO6bDRY2X/R4
	1rIR1dscrtvRqe8c88+Via4NLlAp10zfL+8/9nhzOlOk5ruZqFZOhjFPKi2StUmg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54xb0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:21:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CBI4T002102;
	Wed, 2 Sep 2026 12:21:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqhqs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:21:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682CLbm426018374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 12:21:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575575805D;
	Wed,  2 Sep 2026 12:21:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D72C758052;
	Wed,  2 Sep 2026 12:21:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.47])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 12:21:36 +0000 (GMT)
Message-ID: <2a4b80e4e1912183ba4a5d1046d718b4f455720f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Check for ERR_PTR from dentry_path() in
 validate_hash_algo()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
In-Reply-To: <20260827174339.1729-1-brads@mainlining.org>
References: <20260827174339.1729-1-brads@mainlining.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:21:36 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwNyBTYWx0ZWRfX++4PPuAPGAVm
 rZjN0H25/VOmlrqOVs3SXeUtQvm7EFSj+k5bVLaFxn364EiJ8FtjHUZRQB+9JitxMpqzmlDx3XB
 ovtb8tBq3FZugD8/vamTIbRGyc89VokgbZbr1anNhOZa7/wl5iG+oEFNNkDXZo/52S7rzyB0vIk
 v6Tsapw1OqU9UqSD5PuerBmaemke7csDiW6i5SwvBl6OI7tKheFOMAX1Jsgg+GaTv0yzLBJKpMp
 qHHFayEqXrru1pYWi4mHJw4mAXVYrU2N9/NNYPsnpu9I+rfesZD/v5BsezQyXyIfrU7AENnV91M
 uPuX3wJFMtZZX5ib7tQIed/BQct5rfdxTtMeHc2k32K3m97GlnCYMqA4/NQoy4nxp+OpePR+Ot0
 AwNb3cPzS3MjV4DQ2fHBHFp7KB2gOyRgeaFvTtYSCYpdtcJd5e3s/9CIUcCMkUcpafdPg0LENAk
 csIgNyyLbKwgM8OVfrA==
X-Proofpoint-ORIG-GUID: 2XIn3zFsB1El5m1jQlahP9Tk70oW9W6w
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9814d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=OuZLqq7tAAAA:8 a=ZfC5JQsLA5OFHaLsyRcA:9
 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 2XIn3zFsB1El5m1jQlahP9Tk70oW9W6w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwNyBTYWx0ZWRfXz57ABnoej3aj
 MR4i+Wa7l8dU7olZ2fiG03VMXJCMdw9ztXP0EEdjbu0XO/jdbBSCXJ9B09TN36QZwyxZ0AwP9VI
 Segv5JoD0etN7iEtwGU6cfYE207Djw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020107

On Thu, 2026-08-27 at 17:43 +0000, Bradley Morgan wrote:
> dentry_path() returns ERR_PTR(-ENAMETOOLONG) when the path exceeds the
> buffer. validate_hash_algo() passes the result straight to
> integrity_audit_msg() without checking. ERR_PTR is not NULL, so
> integrity_audit_message() sees a valid pointer and calls strlen() on
> it, which faults:
>=20
>     BUG: unable to handle page fault for address: ffffffffffffffdc
>     RIP: 0010:strlen+0x30/0xa0
>     Call Trace:
>      audit_log_untrustedstring+0x19/0x30
>      integrity_audit_message+0x366/0x4f0
>      ima_inode_setxattr+0x512/0x5f0
>=20
> Check for IS_ERR() and use NULL instead, which makes the audit message
> skip the name=3D field instead of crashing.
>=20
> Fixes: 4f2946aa0c45 ("IMA: introduce a new policy option func=3DSETXATTR_=
CHECK")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/6a8f89e5.1d9ded08.62e62.00bf.GAE@google=
.com/
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Thanks, Bradley.  The patch is now queued in next-integrity.

Mimi
