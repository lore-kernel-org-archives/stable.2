Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559484;
	b=CZGgedDpfd+dXNLQf/GAieqc0f/uiIdbX0nPnIEuZUknZjipaLi751JvBwlk1ESDA88y
	 3uK01AGUaNyo9HmBA35SlEnJSgryiX2AP74YBz7BfYUUorgmaP/X2xcE8ZyX6/d2xFb5Q
	 8oTN461ZoEF4BJWS22keDMmOqKQwF3OmRO2htNdGCkYGdJ6vmkTc+PtcW1fgn7NsWblNQ
	 1gYRjeWV/hR380LHRUvXvvdmIG5foTqHZlObDkQbqlxk+kDMul7/bJpkOGspj6hg9J4Mb
	 CuKurcPtFQFePDAOwY2JSGlxUAC/Fjnt7saAj1p9skI0C8BYNk6cJzOObp1S8lidmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559484;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CXYY2davx3hhXmREYRpR7y9c/hR6BJTh9T5lsz/xFXw=;
	b=W3uJcVhSIhmo0U24tc3ByzRVvH7X/AwMesOWX9Z1YdRF+GFdrgs9iAU+/R6qBl3RY9jS
	 gt9GKJdApYKyO/OnHCwjThzBkKG40fHb//YJ4nJ95MnXbOZAeSIL3G0Q9cp/lhJTMGyxK
	 OpxqKNLNHu3F3MGK63TY7ttVZkuep0Zl8jMX5f8VUPo9I6wIpCNWT++lmi9JR1Y2DRHPg
	 FoFAg/7hb1l0j75fPPW6gourfcx78WSUUmCBFCErGSmwwdTz0s+XlnqBIveSr/GCZHNml
	 wBsoqAKs2lUnAsQTIe1pTDMfzpf7tnGpq72VbgCoQuZu+PD6sdtJqDRw9AvXzbdLnHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WSYejO69;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=i1WVUosU;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53236606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 18:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53236606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=WSYejO69;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=i1WVUosU
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1FfZTq3750882
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 13:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CXYY
	2davx3hhXmREYRpR7y9c/hR6BJTh9T5lsz/xFXw=; b=WSYejO69CfdNT81DJFNR
	cTmv2KRMB2Od6Hr6tPG8f678k8F9kgVny2jDKBb7rzPcX8OzDcQ+Q/nHuHfrLMBE
	Wuvye5NceqxWELSLKYTzrwKWhInhEq2ZXZiJjH7TiVJP+RrydeRait9QXjJrohcn
	IazreHB5Ht8aD5qiFeapcTqQhP211JwT3xRQ+WQkTye4Izdv+tuDejCl1m2eL13x
	+UV70Q0BlGM7Qt9pKdSq4W3CqfSrDl24yloIiDMU1BmVJG5/YcMYV/Xi5lp0QBRn
	4g5Tnui1BW2bPVelveiAE51q0wprWe7sX0wMBqJ6dvkasteXLlVlFjeLZWPU7bol
	tg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hp89qgvs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 13:58:02 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb71b1443so486081385a.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793559481; x=1794164281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXYY2davx3hhXmREYRpR7y9c/hR6BJTh9T5lsz/xFXw=;
        b=i1WVUosUK+tKdPcwdvkB8p8ZsQvohzdzyFrUraXdDbEUo/GBwHzZFlm/pN2ozsMog+
         /IO/jLYPgXsTUuWDefz4vlq21tHjFWxHifdIGbyUlOVrzNUS58zS5A9pRg4TA+TjPWqn
         j5JRsLbXHLmA2UfmdM+xpaSC2q9sC8cCfTurFXpKBBKf60Ck+0IZfJVADIahWuEEUPP+
         ScmyPErtn0Nrx2PEIoerPVNEd26I8OgC83u93rNsmfsxI6fY0OLcDDfIG0eEIJK9B7xP
         MEPlPcRYb2uK0AeAKuRBfL7XdQZhZxJ1IDQ/pz3fy+sJjxheOYGMb+ReHVUoetW6Twbe
         Gbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559481; x=1794164281;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXYY2davx3hhXmREYRpR7y9c/hR6BJTh9T5lsz/xFXw=;
        b=dLAtlZ3UxC2dHBDZiRlTXX93rSSKYXx3f54zSRav5g5RyMfhaI0wGnudMMjF8vDNhd
         aQk6AekWZwgomfe/+bOkARYGnl90qhjF56730SxI8WJrBiZkGEazBgmCvmvytOt+1i4X
         z7Nf026dPed1BCynK0Xb1WNToYArsTZZGdfyLsfKlbhLjpsXHwREaz+hpkEb//ASXJYo
         Dj1CsbJIxHCPsjExYbjauFZXJzAc49gGmLSuQXlOeCv4+GoZZegRk8XvxiALG6EY9bfC
         1sc6YAPrRqvLKE+CazdE3xVTWD4e+bg3rlviFawKZs2+dGX37sjihAaJJUFj/kqrg49+
         M09g==
X-Forwarded-Encrypted: i=1; AKwUvBwG+9Vg0ZPlKaQKMb8k4oX36JNGWjxd7Yg8HcB7Wt5h82bH1YgZYZ7/VWCpP3xXYiMZ7sFPsis=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcHSF6FvYeKoZtY5/mrGKCcOXDvJtkyASsRQH2sR8hu+bdurnh
	YHOsB01ASGFIR9OeUh4s7mV/I3ENYqlpBn4yNTZHVFwvoh6Jc9D0I1M43Ji/3uhlxVC0svsJufB
	pFvXll2tTKrGxcF8gAmvVapqVVNmkP2c6jxaxvuzcGfABV7R3mYiRQg==
X-Gm-Gg: AYBFou1jCeVMtKbCIKH/pNPNtomYXE+LyPqosrZ5eG7r9T5iv8q1kNDvzbMCr8aewat
	KselFrxqiF8Vo9bRzr88UheyNSUfpMJFRb5IDPRytpP7c0HH00fGAz+t9wDR7XBGaczkVxZOhVv
	VAR7QvEKDmhiHSTyBotFTK7yspOz1uSjV0kkd8LxN0j3xvkcvvTXXOzqBDqk6mnO8tnybJrJb3a
	w5mGT6nzTy27YSYVNRwtJAVXk4xvltsG+HAml9XWB8DumV4307yvCfSa0Vwd6Gxe2cZm/egM1Rt
	a/uGUja9UJtu8Cn4nGbsrwSFE6ZVt/gaDWJt1650nxIiSuMhkAqFkryGWbNpnYfFrsVloWBGevJ
	/bcwsNtqjMEbnoaLfFwshmT6xlgQpL0RkrRa6eq5BL3FJgnf51ln6J3TZrCG3xQNYpT1thGCN1Q
	k8t460sMi/Pc7QewvdW8J9aNaTSns11avDGhU=
X-Received: by 2002:a05:620a:468a:b0:93c:8544:6ad8 with SMTP id af79cd13be357-94421747024mr1398579185a.28.1793559481407;
        Sun, 01 Nov 2026 10:58:01 -0800 (PST)
X-Received: by 2002:a05:620a:468a:b0:93c:8544:6ad8 with SMTP id af79cd13be357-94421747024mr1398575885a.28.1793559480868;
        Sun, 01 Nov 2026 10:58:00 -0800 (PST)
Received: from ?IPV6:2a00:a040:199:85d9:400f:a731:3a5c:25b9? ([2a00:a040:199:85d9:400f:a731:3a5c:25b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm205875525e9.8.2026.11.01.10.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 10:57:59 -0800 (PST)
Message-ID: <b8847a58-1c43-46a8-823a-4ad7a14c8f93@columbia.edu>
Date: Sun, 1 Nov 2026 20:57:56 +0200
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
Subject: Re: [PATCH v2] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
        Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
        Usama Arif <usama.arif@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi
 <nao.horiguchi@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Nico Pache <nico.pache@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Li Youhong <liyouhong@kylinos.cn>, stable@vger.kernel.org
References: <20261030-try_to_split_thp_page-v2-1-c957c9b42eab@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20261030-try_to_split_thp_page-v2-1-c957c9b42eab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX6wkTGEOQ2baM
 RUjbe8zgUVblHZ/Yyfn6DmlHHQCKXXPYmc+0RoNjgdOlW3JH6qkPsl/KTK9UUYBuW7iCxPa0PIx
 +gZ6qRaArpcXgMt7iLQXCt3HCPbU1S0KiTXtIXJP6wflK6QFm5sgrviiqwg46T4VmzhG3Ig3YUy
 J/ySOKVzO6LM8Byf9vU9S/4u5QjnhVBp4bh8O/wfhHgjTQ9GwCdrSyYrrGa1W7XuURQaL8yLLka
 /moZJLWZxMZHwXAxKYQUMDJ6nKIXCNOyWyxHbvLYbuKkbNivOqFraGcQjcdqtHkXqvcgQhKsbDV
 74j6Wfc5pASVhwUrKDRNLVcNHpFTfUDN53Qi879UFqMCRvpq26xYO8BGjB1HipNApZLYAiQ9lgw
 qbUNJ9Gl+lv5Vow1jDDGLrFtiVygfPGODi0EX2xtiGTrXJR8KqcmqEid6ZO97TcLGN6kaLq7Tm3
 CiKyhwlaJt1C/4E4tuw==
X-Authority-Analysis: v=2.4 cv=ML71C8Zl c=1 sm=1 tr=0 ts=6ae78bba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8
 a=i0EeH86SAAAA:8 a=ZVJNLgniXcJRS-GVAekA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfXz/7p3k+JE3mC
 Ag3qEGtqx02+Nq8Jrdw5JRv2n7BcF86JO5ll5eSAt3QnZCvVtykdX+HJ7gVIVSAkVQ81R2vhc5a
 6lMPDSqyEFIW5ytRIytDvVINFtnsdr4OCAeBK49TyueMHjATPHZj
X-Proofpoint-GUID: LxR9MTMp9RcCoEvmw9Tyqbte2C-Q9Ytp
X-Proofpoint-ORIG-GUID: LxR9MTMp9RcCoEvmw9Tyqbte2C-Q9Ytp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=10 impostorscore=10 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=10 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

On 10/30/26 6:29 PM, David Hildenbrand (Arm) wrote:
> hwpoison code can end up calling min_order_for_split() without holding
> the folio lock. There isn't really something that would prevent
> concurrent folio split. Consequently folio->mapping can get set to
> NULL after checking for "!folio->mapping", and if the compiler
> reloads folio->mapping, mapping_min_folio_order() would try to
> dereference NULL.
> 
> While very unlikely to happen in practice, let's just enforce that
> min_order_for_split() is called with the folio lock held. We can
> significantly cleanup the calling hwpoison code, and just get rid
> of try_to_split_thp_page() to hold the folio lock for a bit longer.
> 
> Just work on folios now, which further cleans up the code. We just
> have to be careful about doing the page_folio() after splitting, which
> we have to do already either way. Do not change the way we split for
> now, this needs more thought and should be done separately.
> 
> Cleaning this up we fix another issue: in soft_offline_in_use_page(), we
> would currently have leaked a folio reference.
> 
> In min_order_for_split(), document and assert that we need the folio lock.
> Drop the questionable VM_BUG_ON_PAGE(!page_count(p), p) check entirely.
> 
> While updating the comment in soft_offline_in_use_page(), just drop the
> "NOTE" part that does not add any value to current code.
> 
> The folio->mapping problem was identified by Sashiko, and Li Youhong
> reported it by sending a proposal fix.
> 
> This likely does not really warrant CCing stable, but I expect little
> conflicts when doing the backport, so let's just CC stable because of
> the refcount leak.
> 
> Reported-by: Li Youhong <liyouhong@kylinos.cn>
> Closes: https://lore.kernel.org/r/20260804035828.2684059-1-dayou5941@163.com
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

I managed to trigger a UAF via folio->mapping due to the race with truncation
that this patch fixes (KASAN output below). Soft offline is preempted inside
min_order_for_split() after it's loaded folio->mapping. The file is then
unlinked and closed, the inode is freed after an RCU grace period, and the
subsequent mapping->flags read hits the freed shmem inode.

As noted, the potential folio->mapping NULL dereference is dependent on
compiler codegen. x86 GCC and Clang only load folio->mapping once on the
versions I tested, so I couldn't trigger it.

The above UAF was very, very hard to trigger, but it's less theoretical
than the NULL deref issue, so I think the Cc: stable is justified :)

Reviewed-by: Tal Zussman <tz2294@columbia.edu>
Tested-by: Tal Zussman <tz2294@columbia.edu>

KASAN splat:

BUG: KASAN: slab-use-after-free in min_order_for_split+0x78/0x80
Read of size 8 at addr ffff888114bce3d8 by task mfsplit/230

CPU: 0 UID: 0 PID: 230 Comm: mfsplit Not tainted 7.3.0-virtme #1 PREEMPT(lazy)
Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xd0/0x630
 kasan_report+0xe4/0x120
 min_order_for_split+0x78/0x80
 soft_offline_page+0x900/0xc70
 soft_offline_page_store+0xa0/0x100
 kernfs_fop_write_iter+0x2f5/0x4a0
 vfs_write+0x60f/0x1100
 __x64_sys_pwrite64+0x18a/0x1f0
 do_syscall_64+0xfa/0x5e0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Allocated by task 229:
 kmem_cache_alloc_lru_noprof+0x1e0/0x5b0
 shmem_alloc_inode+0x21/0x40
 alloc_inode+0x5f/0x1f0
 new_inode+0x18/0x180
 __shmem_get_inode+0x173/0xdf0
 shmem_mknod+0xcb/0x240
 lookup_open+0xbb7/0x1760
 path_openat+0xc8b/0x1dd0
 do_file_open+0x1d2/0x400
 do_sys_openat2+0x126/0x170
 __x64_sys_openat+0x122/0x1e0

Freed by task 231:
 kmem_cache_free+0x29c/0x610
 rcu_core+0x691/0x1de0
 handle_softirqs+0x204/0x8e0
 __irq_exit_rcu+0x153/0x1e0
 irq_exit_rcu+0xe/0x20
 sysvec_apic_timer_interrupt+0x3e/0x80

Last potentially related work creation:
 __call_rcu_common.constprop.0+0x80/0x270
 evict+0x4da/0x910
 dentry_kill+0x1f1/0xa90
 dput.part.0+0xa0/0x180
 __fput+0x42a/0xaa0
 fput_close_sync+0xe7/0x1a0
 __x64_sys_close+0x7d/0xd0

The buggy address belongs to the object at ffff888114bcdf80
 which belongs to the cache shmem_inode_cache of size 1400
The buggy address is located 1112 bytes inside of
 freed 1400-byte region [ffff888114bcdf80, ffff888114bce4f8)
