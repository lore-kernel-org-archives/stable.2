Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0A390CAE
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787382873; cv=pass; b=ScmLYr1/Hvbxrk3VFbdambvW4FebA533wInV3lqm6B+eh7K/rETDc2MuZLp54bft+9R4wZ1iD8Nz7FvP69PfEQMzVt8y4RcX39JeL2NoR86bTFbd40DxB/Y3LZLBvqmSvIOMg7W0aRuBI8WemSPHqt+LXNWMU4LCss7OLZHz58s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787382873; c=relaxed/simple;
	bh=TFcM7a4Wbr+h7F48GWzdGRkN9+EF1Ra5ASi9ny1DJQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5fFtyPyY1CAENvvNsel3O6segudHAS3yOBivM9yZWhRzOh+b//+O2XPxsd+mSHSAVdJGB5CKdnjUUqdXrTtjui9cBLwjCyqqMILx5OKxLpxZwM97UYguIYMiw+5ZvjxJysCxDc4v6IL7ztn5I6XJk3/39b1xtyi/ezeD1H9G2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoYwX3x/; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoYwX3x/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so284051a12.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787382869; cv=none;
        d=google.com; s=arc-20260327;
        b=KiwIGwo6IgZy2To76Sws1E4RZiDeni5b2ii4RCPch2CYK5KBSwFNKqMwfEDs07clJo
         dQ6uum0novV+2bmn6nVpJI6fnc187Jmh+9MAPD/kG+txnCuxezMAW9l64AlejNmAt1Hx
         ElAwnGXcaRf5yt31Xp50OKiPE0PBixuElKENmUvP6MsauX+BhWXcr8YcKDwrwTBvcnDZ
         0Xk7oab/gEKQvA8iVI7mOK+gumXZfVwZPXqjgF7VGoHKk/CuMPDiyqHz6edqEWd8CnmL
         mCntYQMkwSQG+Iua5oUcRapSv0/zCZ91FCDaasZrX8acFFPFwKgn0ymE6Ivatux/hMUd
         xIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0iiWOnrMWtNE+XqbHGZEVRVG4sSb50eRnpEz9oyUP04=;
        fh=azUSH0iRYGuA4gwCWM4Fht8ECW3c8tKUyafpu297Ypg=;
        b=dboBgS8zJZehWmX3GiDyWyYybcfz7nLNl28hC2A99Gv+98FAWgo6sFUKHFgXeVb8g8
         EvJRMz996Tj2xTO66QyQwwcZXwAHPkiyPRjMQ2vRORXSwbi7ei1i5JpwKH5iS2jD6kxX
         kZVxRqDSKXRhKf3JoHuFzdFeKZt05KDxpdaX4CvtoWN066tV75y1U57/Q61W/JQligzl
         95jVxYJfDgQy7Gb4du020Y9GtI20c83R8Z84AAHYszvxoEb6UTQsCo7miF4WAnlml8VR
         5Fn5Qpe3RPLwqFVRZcXTqm0BoZ70f9THeC6K9+2TZiL6jmv/wdC1IZeK4cUkWTiyyAFM
         JIAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787382869; x=1787987669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0iiWOnrMWtNE+XqbHGZEVRVG4sSb50eRnpEz9oyUP04=;
        b=GoYwX3x/GwRq5tvn7NbA2fnJvL4pT/vZ55IaeFqTSGiOKzOhAkWgkShk2+fAaEPmmT
         17xC1Ifda8kMr0eeGHqOVegEi2Zux1ljCpba82+SNAtsP2rk3SZhk9D8zsYajx4mFpnu
         Xyg9XPsfSuuCa/4/VVhp2Vn1pt4EYVaoL7bnCF9qSn4S+/6T1ehiSjvNViMoS2yKuTKl
         Tpllk9A9No1Yz6fkzbUl+ahqyZ4IBB/e0vT2vPJHOTH2Z7R6WkanmBbV0CZvVUoSwQp+
         AnEkSqhLDwNAoNIm13GcF8GRTqpkNE4R2RHoeHpeb+/YivQDVh5KiFw8WyA1WgBRAO4C
         DlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787382869; x=1787987669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0iiWOnrMWtNE+XqbHGZEVRVG4sSb50eRnpEz9oyUP04=;
        b=pCKNx2Z2HNJr2g4rP5VGlmLBKuy40Iuv5sdYuUtkTABvNhaSpQMmeKLMoO8NYm8/+5
         76U89Lc9ag7wZ4POJddNRvZ28LsMvLnV+VCdVdNTw3XjxyCzvYDtfpfiOlUPQDb5CR4a
         +BzAuT4QPNOtuJPHvzgm3b91U+o3WmFRQkQ2Nc/VNm/hjR3XiVPLeQ/kJWbNJRbg4m8c
         BeMT2DMdvWvwyfHm4FDAuLaxb0hmN2tmruYYo1otopwESYQvqNosQycWfYFaQo72suLb
         cAWebZ8DfCieUikZ2JLXFlHOBWcYWVLk0+dCiv4/DwWdO1b6bFkhrR98jPYsXG20dL5+
         9xCw==
X-Forwarded-Encrypted: i=1; AHgh+RodGpuvC+l44VZ2SP+YhUa4MQHbiw4pTsDzJaonTIVaQEgnR30WJ3+gLMw9SJQcv4+kLvns/lk=@vger.kernel.org
X-Gm-Message-State: AFuF++lAdBCuQdzTTuDBja3F0wLuYmMddY5eIsJrGmwtZHO6NkAEflRF
	nfNu6he4dcBEEkZgvesyE0rtMYm7/fUarad9I4SjZXHfpJ8jZUWVr4AjOHzd4TgwIhVygdjmKIA
	qx97H31otIb96xGYdRwszuUlcS322KI8=
X-Gm-Gg: AR+sD10X0tHwr9zXFQSS3X+dJLNC/VgB0dsy93tBKKOQj9dq09MJnlao+vsIVGYKNy1
	hEBTaAE7dw3RcvLwm2geCAwpDoJEEzmdVdU8BtGIOPu5Q9f9uJQFpX8+d/Dpr3/5m3m8lGtkEYp
	+UnWoWwr+wVJ5Aj9ivWaEUoUv3lLup6Yz0ZLZoav8KFO8khdTJLbhb3XQby/CQa3CoAy1vlum0e
	y/tYFh3H74CnVodLLJDOxO/nurcmGOnF7ClXi45ijycKzx9Tt9oMxUZheEtotPPY9KQH/WdMh/O
	Jr4Kfr8oNiMsaavlVGYj/BwaVt48FrLft5HrkvMXGBF8K6Gjfu3/Y2d6N7mTfptJcowm+PENVQ=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr6736363a12.0.1787382869116; Sat, 22 Aug 2026
 00:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821174514.3034851-1-nicoyip.dev@gmail.com> <20260821192217.725793-1-ali@iusegentoo.com>
In-Reply-To: <20260821192217.725793-1-ali@iusegentoo.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 22 Aug 2026 15:14:17 +0800
X-Gm-Features: AcwNN1W8UywDMsjZvt1TrUei1vkjHgP3Qq-XXrZOWHSCNpN7I8492C5By12hIWg
Message-ID: <CAAo+4rUJomK9jJ6nHC6LU0AHiR0LhO_Wwp4-Z8iJOo=Za1JR2g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize session teardown
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Jiale Yao <yaojiale02@163.com>, SeungJu Cheon <suunj1331@gmail.com>, Tim Bird <tim.bird@sony.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

Thanks for taking a close look.

On Sat, Aug 22, 2026 at 3:22=E2=80=AFAM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
>
> Hi,
>
> On Sat, Aug 22, 2026 at 01:45:14AM +0800, Chengfeng Ye wrote:
> > rfcomm_kill_listener() walks session_list and deletes every session
> > without holding rfcomm_mutex.
>
> I agree with that observation but I don't think this race is reachable. I
> also could not reproduce the reported splat.
>
> I tested 7.2-rc5 with KASAN and RFCOMM as a module. An open RFCOMM socket
> keeps rfcomm.ko pinned so the module cannot be unloaded while connect() i=
s
> running. Even with forced unloads and a widened add/drop window, I only
> hit execution from freed module text. I never saw a UAF in
> rfcomm_session_del().

You are right that my changelog did not describe the reachability
constraints clearly enough. The reproducer I used relies on forced
module unload via: syscall(SYS_delete_module, "rfcomm", O_TRUNC) so
the path is only reachable by a privileged user with module-unload
capability. Furthermore, to make the race triggering stable, we add
the following kernel-delay log for race reproduction (which is
acceptable approach for demonstrating the bug[1]):

index 2e8c080b4d9e..fb9b4f6d1a86 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 #include <linux/unaligned.h>

 #include <net/bluetooth/bluetooth.h>
@@ -701,7 +702,12 @@ static struct rfcomm_session
*rfcomm_session_add(struct socket *sock, int state)
                        return NULL;
                }

+       /*
+        * Widen the transient BT_BOUND lifetime after insertion so forced
+        * unload can overlap a live session on session_list.
+        */
        list_add(&s->list, &session_list);
+       mdelay(30);

        return s;
 }
@@ -2160,8 +2166,14 @@ static void rfcomm_kill_listener(void)

        BT_DBG("");

-       list_for_each_entry_safe(s, n, &session_list, list)
+       list_for_each_entry_safe(s, n, &session_list, list) {
+               /*
+                * Widen the unlocked teardown window so forced module
unload can
+                * overlap a concurrent session teardown on the same list e=
ntry.
+                */
+               mdelay(50);
                rfcomm_session_del(s);
+       }
 }

>
>
> The splat also looks like it came from a built-in RFCOMM build. The
> missing module tag and the way rfcomm_exit() works in that case make the
> reported path unlikely.
>
> Could you send the full report and the reproducer? In particular the
> "buggy address" block and both full stacks would help. faddr2line on your
> vmlinux should also show which traversal the offset points to.

I will send the reproducer as a separate email as the maillist does
not accept an attachment. The full KASAN I reproduced on the current
master branch as following (where the address would be different from
that on the commit message cause that one was reproduced on a kernel
built roughly 2 months ago):

[   29.867919] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.868407] BUG: KASAN: slab-use-after-free in
rfcomm_run+0x3802/0x3f00 [rfcomm]
[   29.868954] Read of size 8 at addr ffff888111058d40 by task krfcommd/79
[   29.869432]
[   29.869544] CPU: 0 UID: 0 PID: 79 Comm: krfcommd Tainted: G  R
           7.2.0-05126-ga4ff2be345d0-dirty #20 PREEMPT(lazy)
[   29.869550] Tainted: [R]=3DFORCED_RMMOD
[   29.869551] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   29.869554] Call Trace:
[   29.869558]  <TASK>
[   29.869559]  dump_stack_lvl+0x53/0x70
[   29.869591]  print_report+0xd0/0x630
[   29.869611]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   29.869620]  ? rfcomm_run+0x3802/0x3f00 [rfcomm]
[   29.869623]  kasan_report+0xce/0x100
[   29.869625]  ? rfcomm_run+0x3802/0x3f00 [rfcomm]
[   29.869629]  rfcomm_run+0x3802/0x3f00 [rfcomm]
[   29.869632]  ? __pfx___set_cpus_allowed_ptr+0x10/0x10
[   29.869643]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.869647]  ? mutex_unlock+0x7b/0xd0
[   29.869649]  ? __pfx_mutex_unlock+0x10/0x10
[   29.869651]  ? __pfx_woken_wake_function+0x10/0x10
[   29.869655]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   29.869657]  ? __pfx_kthread_affine_node+0x10/0x10
[   29.869661]  ? __kthread_parkme+0x88/0x170
[   29.869666]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.869669]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.869672]  kthread+0x2c8/0x3b0
[   29.869674]  ? recalc_sigpending+0x15c/0x1e0
[   29.869678]  ? __pfx_kthread+0x10/0x10
[   29.869680]  ret_from_fork+0x36e/0x5a0
[   29.869690]  ? __pfx_ret_from_fork+0x10/0x10
[   29.869695]  ? __switch_to+0x572/0xdd0
[   29.869699]  ? __pfx_kthread+0x10/0x10
[   29.869701]  ret_from_fork_asm+0x1a/0x30
[   29.869705]  </TASK>
[   29.869706]
[   29.879688] Allocated by task 86:
[   29.879947]  kasan_save_stack+0x33/0x60
[   29.880247]  kasan_save_track+0x14/0x30
[   29.880550]  __kasan_kmalloc+0x8f/0xa0
[   29.880846]  __kmalloc_cache_noprof+0x15a/0x370
[   29.881198]  rfcomm_session_add+0xa1/0x300 [rfcomm]
[   29.881555]  rfcomm_dlc_open+0x8b2/0xf30 [rfcomm]
[   29.881908]  rfcomm_sock_connect+0x34c/0x530 [rfcomm]
[   29.882248]  __sys_connect+0xfc/0x130
[   29.882491]  __x64_sys_connect+0x6d/0xb0
[   29.882785]  do_syscall_64+0xdd/0x4a0
[   29.883050]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   29.883425]
[   29.883530] Freed by task 86:
[   29.883758]  kasan_save_stack+0x33/0x60
[   29.884029]  kasan_save_track+0x14/0x30
[   29.884321]  kasan_save_free_info+0x3b/0x60
[   29.884642]  __kasan_slab_free+0x43/0x70
[   29.884920]  kfree+0x121/0x3c0
[   29.885145]  rfcomm_dlc_open+0xab7/0xf30 [rfcomm]
[   29.885520]  rfcomm_sock_connect+0x34c/0x530 [rfcomm]
[   29.885824]  __sys_connect+0xfc/0x130
[   29.886047]  __x64_sys_connect+0x6d/0xb0
[   29.886286]  do_syscall_64+0xdd/0x4a0
[   29.886508]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   29.886808]
[   29.886906] The buggy address belongs to the object at ffff888111058d00
[   29.886906]  which belongs to the cache kmalloc-part-02-128 of size 128
[   29.887669] The buggy address is located 64 bytes inside of
[   29.887669]  freed 128-byte region [ffff888111058d00, ffff888111058d80)
[   29.888371]
[   29.888470] The buggy address belongs to the physical page:
[   29.888797] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x111058
[   29.889270] flags: 0x200000000000000(node=3D0|zone=3D2)
[   29.889563] page_type: f5(slab)
[   29.889756] raw: 0200000000000000 ffff888100043c80 dead000000000122
0000000000000000
[   29.890207] raw: 0000000000000000 0000000000100010 00000000f5000000
0000000000000000
[   29.890660] page dumped because: kasan: bad access detected
[   29.890987]
[   29.891086] Memory state around the buggy address:
[   29.891373]  ffff888111058c00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   29.891793]  ffff888111058c80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   29.892212] >ffff888111058d00: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   29.892636]                                            ^
[   29.892948]  ffff888111058d80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   29.893373]  ffff888111058e00: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   29.893793] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.894249] Oops: general protection fault, probably for
non-canonical address 0xe0fd7c116000000a: 0000 [#1] SMP KASAN NOPTI
[   29.894901] KASAN: maybe wild-memory-access in range
[0x07ec008b00000050-0x07ec008b00000057]
[   29.895397] CPU: 0 UID: 0 PID: 79 Comm: krfcommd Tainted: G  R B
           7.2.0-05126-ga4ff2be345d0-dirty #20 PREEMPT(lazy)
[   29.896068] Tainted: [R]=3DFORCED_RMMOD, [B]=3DBAD_PAGE
[   29.896358] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   29.897017] RIP: 0010:rfcomm_run+0x148f/0x3f00 [rfcomm]
[   29.897331] Code: 08 23 00 00 49 8d 7c 24 08 49 8b 46 08 48 89 f9
48 c1 e9 03 80 3c 29 00 0f 85 da 22 00 00 48 89 c1 49 89 44 24 08 48
c1 e9 03 <80> 3c 29 00 0f 85 ad 22 00 00 4c 89 20 49 8d 7e 18 48 b8 22
01 00
[   29.898405] RSP: 0018:ffff888111fa7cd0 EFLAGS: 00010207
[   29.898715] RAX: 07ec008b00000056 RBX: 0000000000000003 RCX: 00fd8011600=
0000a
[   29.899131] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888111f=
a7c98
[   29.899552] RBP: dffffc0000000000 R08: 0000000000000001 R09: fffffbfff4c=
5b440
[   29.899970] R10: ffffffffa62da207 R11: 3d3d3d3d3d3d3d3d R12: ffff888111e=
f9a00
[   29.900388] R13: ffff888100fd5300 R14: ffff888111058d00 R15: dead0000000=
00100
[   29.900804] FS:  0000000000000000(0000) GS:ffff88817557e000(0000)
knlGS:0000000000000000
[   29.901278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.901615] CR2: 00007f2f84a69b30 CR3: 0000000111c02002 CR4: 00000000007=
70ef0
[   29.902032] PKRU: 55555554
[   29.902197] Call Trace:
[   29.902353]  <TASK>
[   29.902486]  ? __pfx___set_cpus_allowed_ptr+0x10/0x10
[   29.902787]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.903074]  ? mutex_unlock+0x7b/0xd0
[   29.903299]  ? __pfx_mutex_unlock+0x10/0x10
[   29.903549]  ? __pfx_woken_wake_function+0x10/0x10
[   29.903833]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[   29.904134]  ? __pfx_kthread_affine_node+0x10/0x10
[   29.904423]  ? __kthread_parkme+0x88/0x170
[   29.904667]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.904952]  ? __pfx_rfcomm_run+0x10/0x10 [rfcomm]
[   29.905237]  kthread+0x2c8/0x3b0
[   29.905441]  ? recalc_sigpending+0x15c/0x1e0
[   29.905698]  ? __pfx_kthread+0x10/0x10
[   29.905924]  ret_from_fork+0x36e/0x5a0
[   29.906150]  ? __pfx_ret_from_fork+0x10/0x10
[   29.906408]  ? __switch_to+0x572/0xdd0
[   29.906636]  ? __pfx_kthread+0x10/0x10
[   29.906862]  ret_from_fork_asm+0x1a/0x30
[   29.907097]  </TASK>
[   29.907233] Modules linked in: rfcomm(-)
[   29.907480] ---[ end trace 0000000000000000 ]---
[   29.907757] RIP: 0010:rfcomm_run+0x148f/0x3f00 [rfcomm]
[   29.908068] Code: 08 23 00 00 49 8d 7c 24 08 49 8b 46 08 48 89 f9
48 c1 e9 03 80 3c 29 00 0f 85 da 22 00 00 48 89 c1 49 89 44 24 08 48
c1 e9 03 <80> 3c 29 00 0f 85 ad 22 00 00 4c 89 20 49 8d 7e 18 48 b8 22
01 00
[   29.909139] RSP: 0018:ffff888111fa7cd0 EFLAGS: 00010207
[   29.909455] RAX: 07ec008b00000056 RBX: 0000000000000003 RCX: 00fd8011600=
0000a
[   29.909870] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888111f=
a7c98
[   29.910295] RBP: dffffc0000000000 R08: 0000000000000001 R09: fffffbfff4c=
5b440
[   29.910711] R10: ffffffffa62da207 R11: 3d3d3d3d3d3d3d3d R12: ffff888111e=
f9a00
[   29.911128] R13: ffff888100fd5300 R14: ffff888111058d00 R15: dead0000000=
00100
[   29.911550] FS:  0000000000000000(0000) GS:ffff88817557e000(0000)
knlGS:0000000000000000
[   29.912019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.912364] CR2: 00007f2f84a69b30 CR3: 0000000111c02002 CR4: 00000000007=
70ef0
[   29.912782] PKRU: 55555554
[   29.912948] Kernel panic - not syncing: Fatal exception
[   29.913315] Kernel Offset: 0x1f400000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

The probably useful addr2line information is like:

### `rfcomm_run+0x3802/0x3f00 [rfcomm]`

```text
rfcomm_run+0x3802/0x3f00:
rfcomm_session_del at /home/cyeaa/linux/net/bluetooth/rfcomm/core.c:717
(inlined by) fcomm_kill_listener at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:2175
(inlined by) fcomm_run at /home/cyeaa/linux/net/bluetooth/rfcomm/core.c:219=
8
```

### `rfcomm_run+0x148f/0x3f00 [rfcomm]`

```text
rfcomm_run+0x148f/0x3f00:
__list_del at /home/cyeaa/linux/./include/linux/list.h:227 (discriminator 2=
)
(inlined by) __list_del_entry at
/home/cyeaa/linux/./include/linux/list.h:249 (discriminator 2)
(inlined by) list_del at /home/cyeaa/linux/./include/linux/list.h:260
(discriminator 2)
(inlined by) fcomm_session_del at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:721 (discriminator 2)
(inlined by) fcomm_kill_listener at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:2175 (discriminator 2)
(inlined by) fcomm_run at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:2198 (discriminator 2)
```

### `__pfx_rfcomm_run+0x10/0x10 [rfcomm]`

```text
__pfx_rfcomm_run+0x10/0x10:
rfcomm_run at /home/cyeaa/linux/net/bluetooth/rfcomm/core.c:2180
```

### `rfcomm_session_add+0xa1/0x300 [rfcomm]`

```text
rfcomm_session_add+0xa1/0x300:
_kmalloc_noprof at /home/cyeaa/linux/./include/linux/slab.h:988
(inlined by) _kzalloc_noprof at /home/cyeaa/linux/./include/linux/slab.h:13=
09
(inlined by) fcomm_session_add at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:681
```

### `rfcomm_dlc_open+0x8b2/0xf30 [rfcomm]`

```text
rfcomm_dlc_open+0x8b2/0xf30:
rfcomm_session_create at /home/cyeaa/linux/net/bluetooth/rfcomm/core.c:801
(inlined by) __rfcomm_dlc_open at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:386
(inlined by) fcomm_dlc_open at /home/cyeaa/linux/net/bluetooth/rfcomm/core.=
c:429
```

### `rfcomm_sock_connect+0x34c/0x530 [rfcomm]`

```text
rfcomm_sock_connect+0x34c/0x530:
lock_sock at /home/cyeaa/linux/./include/net/sock.h:1713
(inlined by) fcomm_sock_connect at
/home/cyeaa/linux/net/bluetooth/rfcomm/sock.c:422
```

### `rfcomm_dlc_open+0xab7/0xf30 [rfcomm]`

```text
rfcomm_dlc_open+0xab7/0xf30:
rfcomm_session_del at /home/cyeaa/linux/net/bluetooth/rfcomm/core.c:727
(inlined by) fcomm_session_create at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:818
(inlined by) __rfcomm_dlc_open at
/home/cyeaa/linux/net/bluetooth/rfcomm/core.c:386
(inlined by) fcomm_dlc_open at /home/cyeaa/linux/net/bluetooth/rfcomm/core.=
c:429

> The locking itself is safe but I don't think the changelog currently
> describes a reachable race. There may be a more relevant unlocked
> session_list access in rfcomm_security_cfm().

Yes the commit message might be not clear enough, I am happy to make
v2 for it if you decide to fix the bug.

Best regards,
Chengfeng


[1] https://lore.kernel.org/netdev/20251128151919.576920-1-jhs@mojatatu.com=
/T/
