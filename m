Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B93B0AEF
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091146; cv=none; b=kyhsYqCKlyneT+XqVW+YdWEes0+z6JcMmY1o7/EEbqkHdWbCgV/t3VWy8NpfCfl152RFdjVWVjEY8BigXA8wqAvh65xjrHgeiNfizBq0rhU4l65XvjnIxjyXacEenKGmKZOaL8t0KEJdcMCYgQZJYq6FdSvJ75KoLxP3/4p+ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091146; c=relaxed/simple;
	bh=o/uLwB/ZLdTGDM5qgnMqn7XqpOXx8vUfbZPnw1YgPaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4dVeFyuTvVBBd1Q3KFVfvlhneU9XVIvkabv1A2i5LyoAkQQWTSOJP34HMpLYEJFM+Lv6S3QJIN/DVmX4tzRFAZ1kM48Y2+7z2xvo3SvAZ3exNttDwLgb/xVc8DUyjR3Dk31RXkcYfvsFPVKrQ2D6/1GBEoYR6r5+0cku5u3Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=R1fYfzRZ; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=AmXOrv2V; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="R1fYfzRZ";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="AmXOrv2V"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67UAqIwJ3451065
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Cga6
	AlYSi7DCvZrZkLitELwSbIPiw2zoKeAlwpkN2QM=; b=R1fYfzRZvSO1FDHDhGXw
	PcaI6hMnEQ/xqggSf7cs1BiJfs1arR1Ga52y2IMmdtQHz9ERH8r+lTSXR7AEIGEi
	uZ0VzBon73C3fwyQew/NIGcr97SjbOHZzm4ndo3vN47Hgtuz8eiDxisN4zVftZHh
	W1XyGiVVqTuueMMPOd5OlGyGeoOvQEdUKdi3Il2hRko9Z5HKsURS6SGZYDnTqo/M
	eE4Wf6UQACIzzDcNudBTmUHxNEuz5PdrK2iL/RlD2M8hcoD+YJpMfdLyAiDfEdTz
	uO0sJoyhcu9HpCUg2oEmRXt9/OLYJyqPrwfsdwiRWd+g4lWtMqABYNzeZav8GgZk
	HA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gbrhq59h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:59:02 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52fbe82671dso36933181cf.2
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788091142; x=1788695942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cga6AlYSi7DCvZrZkLitELwSbIPiw2zoKeAlwpkN2QM=;
        b=AmXOrv2VWRyDaOVvRlVmINAaOLSjDygO++DzRs4t/tjCGJZb7glUKAgajUB4XT19R3
         KMYVaUVA41cz9IYSr/bG9R4qCn+LL9eXOdoY+gmC8a/nmJtNK/4AuGsA3fpvivU3Ieqz
         MKOep5C9PtPbtnnDrg6QbZXJS+hCIjV0so+BMgDyi2GaYDVI9vXwWI1Z2HE1itkKf7r4
         4k/MV41Dz4JaTQ7y2AWwUXeaz8Zi13t9WTGPeuY7q6RzfJ2+GjFE7dStNcUbA6DbJGdr
         v31XdhISZ1HYfKPx2n53VdCe1HPSlLCcj5adgZnxprH0JEW36uWMPQ0gNYAlUFsKFLb3
         mMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788091142; x=1788695942;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cga6AlYSi7DCvZrZkLitELwSbIPiw2zoKeAlwpkN2QM=;
        b=lj2LHaWTERn1c5pxy4lJrTyLnAD03kGpTW9VxuvBvspvozm1IE14WI/JD5ObRj8rv6
         RgSXKgAxkxExkk2PjSdVOsd4lY5PLZxKWtkPiKp5B7znP/lOwqLi1qUndlAsdGH7q18G
         CmabB2Y2cPNnzWfce/pqvsfOP1KVmncDlQ91DOiEfdxh3rAedfbmwM1xk/EHeA1aCqLu
         d3TDRZW+VBLrR8VfQTn7ewD9M+qeB9bX0CyO5DCXoIsSCRPKaRESSSVDO6yQKMsw6vhB
         n017B3hvm/tCluG0Yg40wngd5lH+SMhYI8yIq+EuEpJxU+U9i482sJjIWecZY4SJfDyt
         +kYg==
X-Forwarded-Encrypted: i=1; AHgh+RoGQmWDokKW7tgIqhovQPYAoGg+NoRKW+enNhiBM2VCTdxXiUwwsEgO+D/OwjuBNL35ZJJm8W4=@vger.kernel.org
X-Gm-Message-State: AFuF++kl8Pj1TjDmjzlAECVYOhadyw4t97nKO1+qVsRUb1+EgRM+p7NG
	NHuykQCGGDDpEVY4Khouyv3sHclvdMBwjDU47xtqwthVHGiWZHZHx7iSC+qvzk/hdDKDQL5faB+
	onpducMQ4F3ZUwjSeWtBNM8VjP6MAzvXUSdu1p6jPqPtzjcoxWdjcmw==
X-Gm-Gg: AR+sD12RaTihdQCoM899OjL+dGhNzrnEaVgxEaOIAIiW/h2vawONB+2ry/r7ffhip+X
	C3/BUTYUk1FIuAWeQDnItx4cVErNWPv2+nA7kbT6r082g5T4Gdjay4hytIZY4P1BxDV6unxRl33
	koxn9GR9KNGRuUWUmHd4E6RItMtnNottlHqMQUUBJNX1yHx9kXjIX915vRd3gdt/hv0id9euN3C
	zf1YXrUyh3JhDcG8K4jg0pvM8Cq13DFOYf8oj5uLL1j2AiFryq4aWgMy622U6TC22TGXy4CDEa4
	j/3QUPga0Es+KzgQBNIFYRnZfFcNktZKMAdj+IADIjCx9XuQTgQob2sKEMhAhOOOkLytc40wira
	u/9DTRyEFr4kFej70fzLcROicmt1IFz4o+s4CXs/sDSgKak0=
X-Received: by 2002:a05:622a:550a:b0:52b:4e1f:940e with SMTP id d75a77b69052e-52fb93b34b5mr233769001cf.1.1788091141984;
        Sun, 30 Aug 2026 04:59:01 -0700 (PDT)
X-Received: by 2002:a05:622a:550a:b0:52b:4e1f:940e with SMTP id d75a77b69052e-52fb93b34b5mr233768661cf.1.1788091141539;
        Sun, 30 Aug 2026 04:59:01 -0700 (PDT)
Received: from [192.168.0.175] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm16562243f8f.34.2026.08.30.04.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 04:59:00 -0700 (PDT)
Message-ID: <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
Date: Sun, 30 Aug 2026 14:58:58 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        baohua@kernel.org, axboe@kernel.dk, trond.myklebust@hammerspace.com,
        jaegeuk@kernel.org, chao@kernel.org, qiwenjie@xiaomi.com
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDEwMSBTYWx0ZWRfX5BWvNyVkakf4
 MvmnMBdfRZSOZvMhHQFiAqXyzN9+qj8Hyji75qifGhwmzNvyTxHhJjNMMixgoWFvXHryiq8NK+7
 467H/+gZ0Wdz0gAr9iZrLMbEjKVw13nED+61zhnnBrDhCiRP1iPoGqlhtNZr5oRMB+h4Usnv27q
 n1NK9JFWaq3Sh+2BhU9GkeYvpBsYFHG948DqfVL0jY0E1IL/SRY4rxmGIEsN3scq+NCqJZFBS9Z
 iAiBq6Q0zYoWgoDF9zLhX5MB66EZV+6dgM9azNLQoEKINzPz3jIGb084JkiGyppZYTHWTozZoPN
 or5Tf/zcJyQWHnok44O1L7JZrMV88yEPrQQKzDFYkQIgekpcrZTPNaRj7ux1b0ytXurI6XFPuHg
 WuZ9aSk1rXCgMcxJYrTecsTEC1eyKiUyOHhco9zk1R0h3K/GD0gmI5v5rcc6jVRMjvmHJKjn1Wd
 4mwWTn3JFQzkwXhYnjQ==
X-Proofpoint-GUID: bV2bWUJxHo__BfNQimi-LW8yGRmzH8Wz
X-Authority-Analysis: v=2.4 cv=PeDPQChd c=1 sm=1 tr=0 ts=6a941b06 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=IeNN-m2dAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=G6hifmNftL5Xi8x2x9UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: bV2bWUJxHo__BfNQimi-LW8yGRmzH8Wz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDEwMSBTYWx0ZWRfX6Z0P1LQjVFmj
 n39JfNXbhTacPLS7cUyqrgu9d8Czs0JsQoAJC/Kb7cW+uoQ1mtQZEfB/R+c4mxdSaKLReiNQcdU
 9H65wCApCj23KzpKG2vVBe2CLUztNndBIvapJf+WEVPUiqGkS+12
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11890
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=10 clxscore=1015 adultscore=0 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608300101

On 8/30/26 6:25 AM, Wenjie Qi wrote:
> From: Wenjie Qi <qiwenjie@ xiaomi. com> Fault-around can map ready dropbehind 
> folios without going through the normal page-cache lookup that clears 
> dropbehind. A mapping represents a competing cached user, but writeback 
> completion can currently
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
> ZjQcmQRYFpfptBannerEnd
> 
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> Fault-around can map ready dropbehind folios without going through the
> normal page-cache lookup that clears dropbehind. A mapping represents a
> competing cached user, but writeback completion can currently unmap that
> folio. A later mmap access must then fault it back in.
> 
> Retain mapped folios instead. For a mapped folio,
> folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
> i_mmap_rwsem and may sleep. Retaining the folio also avoids this path when
> folio_end_dropbehind() runs in non-preemptible task context.
> 
> Unmapped dropbehind folios continue through the existing invalidation path.
> 
> Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> ---
> The mapped-plus-dropbehind state was reproduced in QEMU. The patched
> kernel retained the mapped folio and continued to evict the unmapped
> dontcache folio. I did not reproduce the sleeping-in-atomic warning and
> am not aware of an existing report.
> 

I was able to trigger the sleeping-while-atomic BUG on current mainline with
some help from Claude. The reproducer itself is straightforward enough, but the
configuration was a little finicky. The atomic context comes from using
threadirqs so that virtblk_done() completes requests from the irq thread under
local_bh_disable() and the vq spinlock with irqs off, so in_task() is true but
the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so completion stays
in the irq thread rather than softirq) and ext4 -o dioread_lock (so end_io runs
inline instead of on a workqueue). With v4 applied the bug is gone, so:

Tested-by: Tal Zussman <tz2294@columbia.edu>

Full splat:

[   46.745106] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1573
[   46.745183] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 61, name: irq/40-virtio1-
[   46.745211] preempt_count: 201, expected: 0
[   46.745233] RCU nest depth: 0, expected: 0
[   46.745292] locks held by irq/40-virtio1-/61: 1, last CPU#0:
[   46.745324]  #0: ff1fce9901fc2f20 (&vblk->vqs[i].lock){....}-{3:3}, at: virtblk_done+0x56/0x100
[   46.746801] irq event stamp: 1585
[   46.748015] hardirqs last  enabled at (1583): [<ffffffff88dc7c54>] finish_task_switch.isra.0+0xd4/0x360
[   46.748224] hardirqs last disabled at (1585): [<ffffffff88e2b16c>] irq_forced_thread_fn+0x5c/0x60
[   46.748405] softirqs last  enabled at (1578): [<ffffffff88e2b159>] irq_forced_thread_fn+0x49/0x60
[   46.748580] softirqs last disabled at (1584): [<ffffffff88e2b12d>] irq_forced_thread_fn+0x1d/0x60
[   46.749233] CPU: 0 UID: 0 PID: 61 Comm: irq/40-virtio1- Not tainted 7.2.0+ #5 PREEMPT(full)
[   46.749323] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   46.749472] Call Trace:
[   46.749552]  <TASK>
[   46.749653]  dump_stack_lvl+0x66/0xa0
[   46.749747]  __might_resched+0x154/0x260
[   46.749787]  down_read+0x1e/0x170
[   46.749806]  unmap_mapping_folio+0x74/0xd0
[   46.749854]  folio_unmap_invalidate+0x92/0x200
[   46.749886]  folio_end_writeback+0x51/0xb0
[   46.749906]  ext4_finish_bio+0x36d/0x3a0
[   46.749979]  ext4_end_bio+0x51/0x140
[   46.750010]  blk_update_request+0x101/0x4d0
[   46.750045]  ? detach_buf_split_in_order+0x18c/0x1b0
[   46.750098]  blk_mq_end_request+0x20/0x130
[   46.750135]  virtblk_done+0x75/0x100
[   46.750173]  ? irq_thread+0xb3/0x2a0
[   46.750190]  vring_interrupt+0x8c/0xd0
[   46.750205]  irq_thread_fn+0x23/0x60
[   46.750238]  irq_forced_thread_fn+0x35/0x60
[   46.750261]  irq_thread+0x17c/0x2a0
[   46.750274]  ? __pfx_irq_forced_thread_fn+0x10/0x10
[   46.750299]  ? __pfx_irq_thread_dtor+0x10/0x10
[   46.750333]  ? __pfx_irq_thread+0x10/0x10
[   46.750353]  kthread+0xf6/0x130
[   46.750369]  ? __pfx_kthread+0x10/0x10
[   46.750404]  ret_from_fork+0x248/0x350
[   46.750421]  ? __pfx_kthread+0x10/0x10
[   46.750442]  ret_from_fork_asm+0x1a/0x30
[   46.750585]  </TASK>

[   46.752964] =============================
[   46.753047] [ BUG: Invalid wait context ]
[   46.753230] 7.2.0+ #5 Tainted: G        W
[   46.753353] -----------------------------
[   46.753438] irq/40-virtio1-/61 is trying to lock:
[   46.753533] ff1fce99004e4990 (&mapping->i_mmap_rwsem){++++}-{4:4}, at: unmap_mapping_folio+0x74/0xd0
[   46.753882] other info that might help us debug this:
[   46.754000] context-{5:5}
[   46.754062] locks held by irq/40-virtio1-/61: 1, last CPU#0:
[   46.754171]  #0: ff1fce9901fc2f20 (&vblk->vqs[i].lock){....}-{3:3}, at: virtblk_done+0x56/0x100
[   46.754371] stack backtrace:
[   46.754441] CPU: 0 UID: 0 PID: 61 Comm: irq/40-virtio1- Tainted: G        W           7.2.0+ #5 PREEMPT(full)
[   46.754656] Tainted: [W]=WARN
[   46.754725] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   46.754887] Call Trace:
[   46.754942]  <TASK>
[   46.754996]  dump_stack_lvl+0x66/0xa0
[   46.755082]  __lock_acquire+0x92e/0x1a80
[   46.755197]  lock_acquire+0xcd/0x2d0
[   46.755282]  ? unmap_mapping_folio+0x74/0xd0
[   46.755403]  down_read+0x42/0x170
[   46.755476]  ? unmap_mapping_folio+0x74/0xd0
[   46.755565]  unmap_mapping_folio+0x74/0xd0
[   46.755664]  folio_unmap_invalidate+0x92/0x200
[   46.755763]  folio_end_writeback+0x51/0xb0
[   46.755851]  ext4_finish_bio+0x36d/0x3a0
[   46.755958]  ext4_end_bio+0x51/0x140
[   46.756043]  blk_update_request+0x101/0x4d0
[   46.756135]  ? detach_buf_split_in_order+0x18c/0x1b0
[   46.756254]  blk_mq_end_request+0x20/0x130
[   46.756349]  virtblk_done+0x75/0x100
[   46.756438]  ? irq_thread+0xb3/0x2a0
[   46.756515]  vring_interrupt+0x8c/0xd0
[   46.756595]  irq_thread_fn+0x23/0x60
[   46.756678]  irq_forced_thread_fn+0x35/0x60
[   46.756768]  irq_thread+0x17c/0x2a0
[   46.756842]  ? __pfx_irq_forced_thread_fn+0x10/0x10
[   46.756945]  ? __pfx_irq_thread_dtor+0x10/0x10
[   46.757045]  ? __pfx_irq_thread+0x10/0x10
[   46.757136]  kthread+0xf6/0x130
[   46.757207]  ? __pfx_kthread+0x10/0x10
[   46.757302]  ret_from_fork+0x248/0x350
[   46.757383]  ? __pfx_kthread+0x10/0x10
[   46.757466]  ret_from_fork_asm+0x1a/0x30
[   46.757594]  </TASK>


> Changes since v3:
> - Describe the forced-unmap/refault runtime effect.
> - Record the reproduction boundary and add Cc: stable@vger.kernel.org.
> 
>   mm/filemap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6afec636881f..00fd89cf6f55 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1616,7 +1616,7 @@ static void filemap_end_dropbehind(struct folio *folio)
>   		return;
>   	if (!folio_test_clear_dropbehind(folio))
>   		return;
> -	if (mapping)
> +	if (mapping && !folio_mapped(folio))
>   		folio_unmap_invalidate(mapping, folio, 0);
>   }
>   
> -- 
> 2.43.0
> 

