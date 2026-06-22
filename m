Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF131235358
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157538; cv=pass; b=Ex0IWoVS70TL7Sg15lkh28sR+RnxccOydT9wC+GcyFyluQ1W4exQ6oJph90+z0ZplpaVMY3HABCYAAPh1gTAb/PzLOopr8BPRlL+pdT/W3MbWu+PatusZytg37WnOqXydZyy514VFA5kMKecoh66rXWmYxXT7W7Kfhwa/U9d0dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157538; c=relaxed/simple;
	bh=wLfi77vl6bxANim/wz75ppi/eF63rTePavhkomsCyFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOqIU0rL+NQ8CTbZR53XO1prid1dCgJTcSUt3oBMhxWFHIVKO3tyeIDC/DqA695wTqqaxhiXnqJiSE1MNO3cE8ArrE7vy4lZ9D+lVr+JmFZyLBfGoLYyLc2t1gWFTuS/W7FxR0UWT6OotxtyI2yK0iVNP6d9o/mGQk0MbNNnPhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgoGMeqM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=af9gDaDc; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgoGMeqM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="af9gDaDc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJb6Ou2177335
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KjoHWP/GNd8XzkURSsjarJERcmLz0FeprGXlq7m6kmw=; b=QgoGMeqMygnqk2Y/
	joGIOnPfDp06RjLx8Df6pM0vBcNl5GbpKU5S33Bs0SIAJLQ6pTovIWZ5NqQ6CXDo
	F/J9Vx4RaeWCDHgi97HLJ3yVOmg4do/SMz7fIBes++CZrkW2cCkeaJ8fbaf/HuVK
	avK3HNNor+QK8q+mbhnmE1cLRbp9CxZ9jtBijcAyEVHF0L1+9ythRuMz3oYcuBxp
	8528JW9aYMK8PLg4k9Y0coDTc2P1Ithl18BYKzFCv5hP/cnBEonlrrb7G9rp1CZr
	ZRwzaePlQEUKLtPZ3pNJIHloTFG4HI2yhA4Foh54ES8o4upQcKASI9HDw+pCOmuF
	S3pPVg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37ha0ms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:45:34 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-806a62af18aso807817b3.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782157534; cv=none;
        d=google.com; s=arc-20240605;
        b=b9LBWyFf7AgsPbteciLnrUE4LQC2ZjCIbcyOFlQuEsEi7CTup4HwE9NYjz3TMkoVnN
         L3VQxcUJ7S8lfn28mO93FrBzIuzyukmBhJi4MM/Gao+hy/UAl7swGxW8wXjKrWFbtYY0
         O6hmZ1ulhU/s6xx93/WxwLos37hzH/aF9LEpjKB9PvzE17cSMSaeu537jjjGwfFpLY1h
         o92y+4QfmS6ph1ahh8lr8jTmON3lUElqtSJ7Jq+GIpfttvIe+WHM9alCdQu5BcV+3Wnp
         dqvGk9c3WZ8EcmQ1sz74p2A/qDn5x2KvlMRoJnBU5H51Op3fQTkGdG2U3umoJWwbRT+5
         YZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KjoHWP/GNd8XzkURSsjarJERcmLz0FeprGXlq7m6kmw=;
        fh=wP9CN8yY7oqjmeApubatITBma2HgzYcIE1NIQSKp7dY=;
        b=V6pZrdnjur7eKfUiALjW0v5ZyDx3NirUZ5yKXFayxJTjm3AhLXBHTHsCUjpPmUAAfI
         oGqtacP9cP7G20FFuI12Wn8Se/zF+ZAJSJU041EgTUsXwyiUywDMQNKKE8Epd2kNIvh9
         r797KIrUDbxrQdfwhpk3E0DAsc6EuJpQiCE3bQzm5ED1RA7zr8GPALt4VYNdGJk+5GXL
         WrxY5AlINAOpklXIGB4rgCFyXM0vRQlMHjm85j7C5+uMvPZN+3V3Cnl27e0/PgyRJZ9x
         xx7ltc71C57pMz2YRxMCA7+EUjDWS92vjvxH7wIGlHOuXDtbd1RqzFnwAMzAJ1bWcWTl
         uicQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782157534; x=1782762334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjoHWP/GNd8XzkURSsjarJERcmLz0FeprGXlq7m6kmw=;
        b=af9gDaDcczKJB668Tz+UmzqrCWrLuAe3L3efwkABkUxmK3wn1inGifZm/syC6L1ORk
         s+bqiGTqsZdlrcQs5MjmS2bBzTKjVrDrpnihzSYDCbowjGEVu+UHPs0XHqRrLYV+dLK3
         n/W9jCPi+b8/Pg54h9JWQGF7SK7j59kuOH6JOlOyB86jEAGtbBzVyjdUDIFLX+GqKVG/
         IBeMkQMwCNMN14enzLG+axYnSk8UU+vLTJhDXPEUMe5MT1Aq6A3YoOrfvxDB2W1+Dgox
         i0YrsEj9VeZxw77NwxiCGNkQWCSdfnO9nATwP1YmCvwbipCaXWkHHqhUghltzlzgGXdL
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157534; x=1782762334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KjoHWP/GNd8XzkURSsjarJERcmLz0FeprGXlq7m6kmw=;
        b=qqrJA6YAP+N+kbU9e7GGszLVMxMVN/qkAH5xeX6XLxOyzBWVWOvvD1cA60S5v4Zntm
         zFnsvhqZ+ouT0gRVOKDqmVCUCCLZeaj1ZvG69sy4L60AiHifgBrj8snrKDR9Fy54Uv/7
         yu7vrDJhoo7yLR4+hNXOePy5pP807tMbziVRb1N0ntYy2TKnrhqdOZEnC03+v9HLi8S9
         IBccGJkrh1ljvssh5XNZu+lwlhuM+pioTYMd2rkI/fXvz2/8vkInqD8Y+aeNDe8d4jVq
         iZFAzjq5WjSvUV/vTub5CcOqSEZE4bll/zH3Q1koMamgX11MMsqLr30eZ3ENeG+MsMEy
         Hvtw==
X-Forwarded-Encrypted: i=1; AHgh+RpeK5f0yy7kQlehqLU1qPAYFb9uBQ1VX92wC/yThOt6Hxqa2b48cLUzmTEDuyAO2MiOmR+LDGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50ST+Pq+pecnAySpxIoWt2urjHZjIj38I/nFNHpGorL2dRvpi
	/GB9Ov/DBNHN7JM3ao+j2YYqfYFNbknDQByAblN7H6j8cDvBN6cf94bAWO/asCCLQLufU/k704j
	B/X0aubWnJViGsYrzoCAVR8kZ+0pDL2riPvxpsBRkj1CWQXtlRKvVyn/+VK/6CD2N80twBH9tT3
	VWgMpqpPimYPiFFIvbFeLb2QkKmtBJVYNDDg==
X-Gm-Gg: AfdE7ckN3wfEzgfpuO9Js9VCWSerH337Mxf7PL6ObU8bWoTbjBQZq7urCfg+OlBXQGf
	SO9tfyu9BugBjc2j12gfzeHHZE6U2mBYqiJn747W29QWW/yaviV0h1o3JN/PD5nadWlBoWPTCX3
	PUVJj5SRj6s41lDBLXv+rhCiPrR+1nKDa/h2kTzfFjmJMtYdYbaNAVBgmt4g86wxzLcjjD
X-Received: by 2002:a05:690c:b14:b0:7bd:577d:7828 with SMTP id 00721157ae682-80134c787a7mr171856367b3.31.1782157534062;
        Mon, 22 Jun 2026 12:45:34 -0700 (PDT)
X-Received: by 2002:a05:690c:b14:b0:7bd:577d:7828 with SMTP id
 00721157ae682-80134c787a7mr171855877b3.31.1782157533540; Mon, 22 Jun 2026
 12:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a396a5a.ac26f6c2.9a9c4.0000.GAE@google.com> <88AEEEF8-B9D9-48C8-9069-00E8528BB619@nvidia.com>
In-Reply-To: <88AEEEF8-B9D9-48C8-9069-00E8528BB619@nvidia.com>
From: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 01:15:22 +0530
X-Gm-Features: AVVi8Ce2VS_LW6HKwQlFH8hNBHkfiSM0A_5L0419nLeoXjFofdIM8pmW8_DIuuc
Message-ID: <CAEuHeqQ+AcNwQGB0a+Buqfs=_S339UD521ryez1NGmwZ_e0Jcg@mail.gmail.com>
Subject: Re: [syzbot ci] mm: page_ext: add count limit to page_ext_iter_next
 to prevent invalid PFN access
To: Zi Yan <ziy@nvidia.com>
Cc: syzbot ci <syzbot+ci8a7f89fd8f70a458@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, david@kernel.org, hannes@cmpxchg.org,
        jackmanb@google.com, kernel@oss.qualcomm.com, liam@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
        luizcap@redhat.com, mhocko@suse.com, rppt@kernel.org,
        stable@vger.kernel.org, surenb@google.com, vbabka@kernel.org,
        willy@infradead.org, syzbot@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SMpkVK064KKmRRLhSPZDrRMSvunHlv4e
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a3990de cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-ibLmwfWAAAA:8
 a=Oh2cFVv5AAAA:8 a=Ikd4Dj_1AAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8
 a=Ddikh3kw0lfEB4zVT9gA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=A6MkUVyZPcTV1i89ro0M:22 a=7KeoIwV6GZqOttXkcoxL:22 a=cQPPKAXgyycSBL8etih5:22
 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE5MCBTYWx0ZWRfXyxIHbThjRxHH
 4KMYY1oW4iY7kNXrcbCaCpb9w5JOkoPV3eXwGejdBtK/h7msEM/ZmZ9RiltpOte+gQhr9vcUiHr
 3uKZFKmFolOuaQJncQEfBd0I35vUWrc=
X-Proofpoint-GUID: SMpkVK064KKmRRLhSPZDrRMSvunHlv4e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE5MCBTYWx0ZWRfX/BnvUwm3jYOV
 hFLTBNv47dNtw72PvcuYg1soPxSTdTQJa+bRa9kGKFogRBKyTP8aJJX7BQGQqbyGcKiiasSDaUu
 5xXAUn144SFHWwf2hN9DO8Tn/zORJu+fCaqGbPRG2SthsCLOUMX370HfcVJGjgRApKqcrA1mVIU
 x6XhGGnelpDYB8r5CsaTzODh6UTO9wfA1qkeJ8vwikwIW+dA8aSh/P1RV57BQmL8tX/CLAMiYNs
 Rq29rUqbQ0ThE6pXZApkbhu4exQVcorxSP1Sr4GrHScrdMiRjJGQLEt9HLfUyjQnpANrWvgmW7n
 gIo1BpscehH13YMxec9VIcyHjKu7Y4ROrdx3vJIDT2hp5J1ZEuZWQNE5q7U565Tt3xqV4+mCRP6
 jTGybzR1BfUgzkk1/KMMRBME+Ua25D4Tkq1oFudcRM24DtqMlT9aah2Is0+A1ZpTSnLXMErtOzf
 IQhzhV57Ac3qiYVGZqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220190

Thankyou Yan.
i missed the post increment change from the last v2.
i am posting a v3 with pre incerement.

- if (iter->index++ >=3D count)
+ if (++iter->index >=3D count)

i think that is aligned with the fix you suggested.

Thank you
Ketan

On Tue, Jun 23, 2026 at 1:06=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 22 Jun 2026, at 13:01, syzbot ci wrote:
>
> > syzbot ci has tested the following series
> >
> > [v2] mm: page_ext: add count limit to page_ext_iter_next to prevent inv=
alid PFN access
> > https://lore.kernel.org/all/20260622-page_ext-v2-1-135d4cfbc42f@oss.qua=
lcomm.com
> > * [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next to pre=
vent invalid PFN access
> >
> > and found the following issue:
> > WARNING in depot_fetch_stack
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/092dd7dc-cb78-46b6-8703-6044fff2631d
> >
> > ***
> >
> > WARNING in depot_fetch_stack
> >
> > tree:      mm-new
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akp=
m/mm.git
> > base:      e1201ff76176ef666b13d1a4ec6b6190ddc6abc8
> > arch:      amd64
> > compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1=
~exp1~20260514074407.73), Debian LLD 22.1.6
> > config:    https://ci.syzbot.org/builds/18f461a2-7098-44bc-9d42-634b56b=
a48d9/config
> >
> > ------------[ cut here ]------------
> > !refcount_read(&stack->count)
> > WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x91/0xa0, CPU#0: kw=
orker/u9:4/1114
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 1114 Comm: kworker/u9:4 Not tainted syzkaller #0 PRE=
EMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-=
1.16.2-1 04/01/2014
> > Workqueue: events_unbound call_usermodehelper_exec_work
> > RIP: 0010:depot_fetch_stack+0x91/0xa0
> > Code: 39 f5 72 d0 48 8d 3d 7e 1b 4d 0b 89 ee 44 89 f2 89 d9 67 48 0f b9=
 3a 31 c0 5b 41 5e 5d e9 87 67 b8 06 cc 90 0f 0b 90 eb ee 90 <0f> 0b 90 eb =
e8 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> > RSP: 0000:ffffc900079a6ce0 EFLAGS: 00010246
> > RAX: ffff888168b94000 RBX: 0000000000000ce0 RCX: 0000000000000067
> > RDX: 0000000000000000 RSI: ffffffff8e215937 RDI: ffffffff8c28ab20
> > RBP: 0000000000000067 R08: ffff88810495a407 R09: 1ffff1102092b480
> > R10: dffffc0000000000 R11: ffffed102092b481 R12: 00000000019c0068
> > R13: 0000000000000001 R14: 000000000000010f R15: ffff88810afb1dc0
> > FS:  0000000000000000(0000) GS:ffff88818dcb5000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff88823ffff000 CR3: 000000000e74a000 CR4: 00000000000006f0
> > Call Trace:
> >  <TASK>
> >  __set_page_owner+0x140/0x4c0
> >  post_alloc_hook+0x1f9/0x250
> >  get_page_from_freelist+0x21fa/0x2270
> >  __alloc_frozen_pages_noprof+0x18d/0x380
> >  alloc_pages_mpol+0x212/0x380
> >  alloc_pages_noprof+0xac/0x2a0
> >  get_free_pages_noprof+0xf/0x80
> >  __kasan_populate_vmalloc+0x38/0x1c0
> >  alloc_vmap_area+0xd1a/0x1420
> >  __get_vm_area_node+0x1f2/0x300
> >  __vmalloc_node_range_noprof+0x358/0x1730
> >  __vmalloc_node_noprof+0xc2/0x100
> >  dup_task_struct+0x28e/0x830
> >  copy_process+0x79d/0x4380
> >  kernel_clone+0x2d7/0x940
> >  user_mode_thread+0x110/0x180
> >  call_usermodehelper_exec_work+0x5c/0x230
> >  process_scheduled_works+0xa8e/0x14e0
> >  worker_thread+0xa47/0xfb0
> >  kthread+0x389/0x470
> >  ret_from_fork+0x514/0xb70
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> >
> > ***
> >
> > If these findings have caused you to resend the series or submit a
> > separate fix, please add the following tag to your commit message:
> >   Tested-by: syzbot@syzkaller.appspotmail.com
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > syzbot ci engineers can be reached at syzkaller@googlegroups.com.
> >
> > To test a patch for this bug, please reply with `#syz test`
> > (should be on a separate line).
> >
> > The patch should be attached to the email.
> > Note: arguments like custom git repos and branches are not supported.
>
> #syz test
>
> Best Regards,
> Yan, Zi
