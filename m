Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441916;
	b=hR0AHsgyXsrsmmEeJXWzSBd2EgwiK3SRRdEIc4lErWkiM4Svr4eILDCEfR/n+IsBq2RC
	 MNBFKQZm+wI2JVa0Mf4LSDz2t7A562XYgS2JgoMrgPxzukd5Lcf7rRr9VtCPp6gOpE49Q
	 lQgE4eHNQQqO1FbYKG8a632j0YJsJWYZYK7KMasLnhQ6kWilmMXbrklpXPxyqFlLVSUa9
	 a4GP2lqWJX7sLD3r2YUd19SU1T4J5VTrTbcLrxhF3oslqgsV/987Ld6ZD2iIwQzs6LBYZ
	 iMDMADBG9GKepjUGjvNbQJaSe4Y+wD1+LQ5ci3lTencHSlIfTS957Bu8RSddlDJbESw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gvtuSEuq3O0wmB0Ckf3q3uStoiooG+ltEGNRtrN7EfA=;
	b=zUzgUpMAC/2FHUtWRxdleCc1Kt34hbuhZqrPke91ozHk7AmjIC04ViIPlM/GynL22LOd
	 thHIJqRMr7V8eNLHgSJ0/FkWd/Z3HB7nKI6Lj30mNUuS+h+XnCHFxX0QVts6hPJw0Q8rg
	 zXuw27Y6dV2dWB9/SxHms7qMXbmYqFdvxODsjgc8iv3zDWapp3hWMmF6Bn2dqj+rp0Iii
	 edOTtEQX6C6PRvnyMocwCcqgQNFzeJz2iCqFgGU8AAkNt+7gQ6r0kBDQ3QHgKoRQUxze5
	 3HUFVjXfxpQ+qXwpDHa2ZGikDWiCgu1kqKVrLG/FyGm5hEN8CRmcYsTGIzFNIaEXocg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tsJe4qMG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E1606A338;
	Mon, 23 Nov 2026 13:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA3E1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tsJe4qMG
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYQSk3741228;
	Mon, 23 Nov 2026 13:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gvtuSE
	uq3O0wmB0Ckf3q3uStoiooG+ltEGNRtrN7EfA=; b=tsJe4qMGh9Nody8kFfz/J3
	uMqDvQDx0pzTMtPdblVEuujA/1nDcq4nWi8NR1efMMWJMxfbac9NkLishW98IHtQ
	5mnonYawc/+XbZ4D8wjWjUJFM8LWwQkL9qsBUbD7UjmunW7WjFc2gX7QfGwz4vLx
	jIxZh7WZCUV+3w7D1B9NOKNfpvT8u3/Wm5gpqRP1l+rQVmJourEmH1ChR/XoX4r+
	p1HRHaspvz2qsdu7RiPgn4kg9Pw5rsl3b6luZs4kPgukiGYQGa9Yf9o7yf6+6d43
	qPjgZazcU1DzxHXTAYa6Dqwd6YsEMdVMIhkNAs1xuQkZLbY513vRUEirCmmUOG0Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkbe6k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:51:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDJW4I805710;
	Mon, 23 Nov 2026 13:51:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufpt58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:51:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANDpmY531916602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:51:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E53362004E;
	Mon, 23 Nov 2026 13:51:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515A120040;
	Mon, 23 Nov 2026 13:51:43 +0000 (GMT)
Received: from [9.39.24.192] (unknown [9.39.24.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:51:42 +0000 (GMT)
Message-ID: <7f8be085-6489-46e6-b85a-11384fd6fe26@linux.ibm.com>
Date: Mon, 23 Nov 2026 19:21:42 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc: Restore all registers after a traced
 syscall again
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX60a89nYDNEo3
 T6gGKd1vCCWDj7hYUAvKaMvReydX7DWLmCW1VaHnopcxzKAuaCLgG3wLpUUCr0lde3ZxAZVBnmP
 rpZYnDz1wT3Qqj6dHl74SDCSKGyDbNWQCvisX5Y2I7ChjD7+R5fHeaKzzrEkkg7G5aFIHpCWD6z
 Wz79EOxorrSIf5vzVHMVlPSnLHJ71Qjvt/3D6D1+Y1kkw59NRVYbjH8jmKKG8tyOe1Q4Eea9Kr/
 h/LEh+VyUv8gTDkP0VTWF0MjROdMZfT3SgkOy7ZQMfdYXsUdkpDc9zioRyDwL8SUjXe+A/5f1nm
 EG3Qj8PorDlsoLdDxL+6D/xqfUo7HgMVeOz6W25QVt6WNVE9FwVHjU0Lknmypu4vp8EletebU8/
 Xge3s6FIwkLfagESuia3RJD/sNEbS9q8GmwJ2iIBK+/+W8lhRwzbkbvWhRERjl07aKAK07Qxdk9
 3sOUxEjqphQI5Phxelw==
X-Proofpoint-ORIG-GUID: uDWfvm3IACuguBVDH1LeZEt7IcQ_roA2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX7osHGXBlC6Uq
 1NwOWtYW0c8klrcggOHzNhbmsSrkle20woIJdx6DQOTmiMg6lKP4hoEqiDqnvm8U7eIkbBzpys+
 te6yN8wTnXm7ahhgoRG5Lf/Ys1tbJYQ=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0444f6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c-BUV6-UA9RXfy5hkpwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uDWfvm3IACuguBVDH1LeZEt7IcQ_roA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230054



On 10/14/26 4:36 PM, Michal Suchanek wrote:
> From: Bernhard M. Wiedemann <bwiedemann@suse.de>
> 
> syscall_exit_prepare() asks the exit assembly to reload all GPRs, CTR
> and XER from pt_regs only if the thread flags contain any of the flags
> in _TIF_SYSCALL_DOTRACE. With the new entry code based GENERIC_ENTRY the
> flags are no longer set.
> 
> This breaks tracers that modify a stopped syscall, for example ones that
> re-execute the syscall instruction by moving the NIP back by 4 at the
> syscall-exit stop with the syscall number put back into r0: the sc then
> runs with r0 = 0, which is __NR_restart_syscall. dettrace fails like
> this with "No filter rule for system call: restart_syscall". A tracer
> that writes r4 at the syscall-exit stop of an sc sees the tracee
> continue with r4 = 0 instead; with a 7.1 kernel both work.
> 
> Check the equivalent syscall_work bits instead, and drop the now unused
> _TIF_SYSCALL_DOTRACE.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org # 7.2.x: c7585b8e99ad: powerpc: Don't drop _TIF_RESTOREALL on syscall restart
> Cc: stable@vger.kernel.org # 7.2.x
> Assisted-by: LLM
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> [ms: reword commit message]
> Signed-off-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
