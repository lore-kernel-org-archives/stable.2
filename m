Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927159;
	b=hQ/K7/XM8woB8dWZ45/L91SNfWYGEN9Eg87ZQA9UTpVwwwg9otlR3ZXUaV6/zJqlES06
	 KnvUSYnrwivg5616rejs91d35BOsLkyr+WYgWe0butFd/aJxsVHtDwcNZWgoT+kHHr+4+
	 vRAdBlRPZiGDap8RxRQHV+AnY9EnzZ2/aM/BqDrSyiSKcQZncvWES+6SnrAZmPQ48g7pQ
	 eCQ71AqAIlvQvHVlP7pjjs72bxK7bRB1ivmnYy2dkDjn+0G+lDxOZZOlyiPMgVD/EFsRP
	 l0m8cGNhLWrjFPLoOlGNAstHDAxE8PWE7Htiz+8BnXDCD1OULZ5F1fbt8xA59U2zR4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1480WziVmWzWLtrWo0QtqaZspgLV6+CWWBx6N5NDweo=;
	b=UBwelx4l20c2p2bmCjnlTNFMijzHOd67jjPEjpDUyRG0cAMVvjYy5YU484wxND72bz1P
	 Fy4taHNc/mHFi+NNpFKEOrYTXeSjGThjP5CbRhSBvGzBlJzI/ZQmvvP19MdlN7RmP7cAn
	 IdR+vl2fHxa+WpS7AgDM5Di08381JNztTGzcUZuvNK3RefwqKw6hROmrC8w7URngfNmXR
	 KDdUpmqpWurvEkfUvhjmImE+xzd713DesKTlC4Mz2/Tyf5YDiCDBI8wm59nvDQODybJfa
	 pFoInIcEvXZBMkoOod+PV4sgHxmbcDRDS5ZayQBZ9W1cjv4ToSuAi6ET9lHk+JZiEJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=kEEnoX4I;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2257606A31B;
	Fri,  6 Nov 2026 01:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2257606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=kEEnoX4I
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NhIhE2129198;
	Fri, 6 Nov 2026 01:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=1480WziVmWzWL
	trWo0QtqaZspgLV6+CWWBx6N5NDweo=; b=kEEnoX4IndqgxzJuGtYJxYRAR5aEo
	nyKW1gyX3sZApF3YU3m4f4N1pL51j0PS1e6MJEz0fDaPDUFOwXRyQ0zwFYhbOy2q
	y6Arzk2HmzGRjpmHCVT2YZDH7qItk4Bz5SpmPyw8uDukqnTpXDLwA9y7jS47yWr4
	O7uG85gRZLBzd+5BUCeLNXX7UzkVnNtKwGchKbPBgL1zQZxvJJs6zeurwwKew0iR
	fu+yPeJZN3hSV0uH7tUKK3kLMaWRipwP3f7p3VDgjuTRSHAZNLCmFqzA0xK4XqIw
	tZNz/DS1h8jtszBJg5x6k2oenNzVhJPVvuzQwSOhZdonlMj174Wpc7rVA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hs3qmg5nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 01:05:39 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 6 Nov 2026 01:05:37 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <song@kernel.org>,
        <jolsa@kernel.org>, <mhiramat@kernel.org>, <stable@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 0/2] ftrace, kprobes, bpf: mark trampoline/kprobe ftrace_ops permanent
Date: Thu, 5 Nov 2026 20:05:33 -0500
Message-ID: <20261106010535.2137162-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH009.crowdstrike.sys (10.100.11.79) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfX0KZlk93YKuwF
 P80EQg9bBJN69Y+vzDNNi1SGLyaSPWYLHlpnXuyeE0Ek4VV7cXyPE/qt6XzMs6O05Q+2/tEWc0I
 m3hkX+KywR4OtpJVXwet3YG1vTWVAxPuvrwkdHLwQWNceyN+6LKiPFeKBizaAmFcfM+tIuLaOJe
 FX8znbVukGAllrlxIiIfISVL4Sbt5KSDdkldf2a0jX1FZnJVRkTliY7zGPV9HX7I67C52ngfsYb
 ovDTrQDW92idW2k38JUPxgvy7xvzKb5b92x1/kyO8XtTsP+Q9+aCm3goDPIUVscXskUDN/VC2zA
 owB0N+YJpbwVEYrMrovuFTdUmgeA2sQ++bWI9MhdTNs9Dowm6Ts/lAgfRnZopaPqavf3yIHlQeJ
 PveVTGtNOeESoAPD3jleahEdxED1ttGhHqbuoeoZEAoMAwB/KGIUSBP69ABe30lUUviXQsa2kMP
 hQWVnEYdnOQz1CKbvcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwMyBTYWx0ZWRfX6apaQSpnqG9W
 wvTEwL/rdlZoZhXN4Emo/MYSwu0qGJc3bNBMrwXrANthVxXYoHv7/rLBRSbqBPNLZfC3tckmLfU
 9NC4M/Toklo0pJR3keqtKKiRDxAietLhBG/hPEW73JU7ZrffWbGe
X-Authority-Analysis: v=2.4 cv=JuVkP84C c=1 sm=1 tr=0 ts=6aed27e3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8 a=ksgJiKQuinou5blJ7t0A:9
X-Proofpoint-ORIG-GUID: UrX2s4fLU8oSh_e5tl_nDV66CCf4hJgS
X-Proofpoint-GUID: UrX2s4fLU8oSh_e5tl_nDV66CCf4hJgS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060003

This fixes a long-standing issue: kernel.ftrace_enabled=0 silently
disables BPF trampolines (fentry/fexit) and ftrace-based
kprobes/kretprobes. The write succeeds, the hook stops firing with no
error, and re-enabling silently restores it. Livepatch already solved
this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
ftrace while a permanent ops is registered and refuses to register
one while ftrace is disabled [1].

This problem is already addressed by [2] in mainline, but for backport
to stable Steven asked to avoid using that solution, as it was a
user-visible behavior change rather than a bug fix. Instead he
suggested we upstream this work and from there it goes to stable [3].

Changes since v1 [4]:
  - Rebase onto latest bpf-next_base
  - Add Acked-by from Jiri Olsa (patch 1), Masami Hiramatsu (patch 2)
    and Steven Rostedt (both patches)
  - Drop the selftest patch as it is irrelevant in mainline [5]

[1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T/#u
[2] - https://lore.kernel.org/all/20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com/
[3] - https://lore.kernel.org/all/20260820182015.4272b7a4@fedora/
[4] - https://lore.kernel.org/all/20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com/
[5] - https://lore.kernel.org/all/CAOu3gNiaCgfPDjVJrt5hLkDuw9nU8-Om50MhZaP2U--91S9N+A@mail.gmail.com/

Andrey Grodzovsky (2):
  bpf: mark trampoline ftrace_ops permanent
  kprobes: mark ftrace-based kprobe ops permanent

 kernel/bpf/trampoline.c | 4 ++++
 kernel/kprobes.c        | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

