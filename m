Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263103;
	b=2SneV16lGP+76yZnSzx4fA+/m8IYAJTrOH6R6Hn+ejuN5VmCYby9gg5YTQkAjOW5yu67
	 cn5g6rko8c2KIGVdgHKqRoVPJlKBd+B5LPj8XT1eZ5h3zDIN12sCgxHB2yOSfAkpmJUMg
	 x5ypcbgLTsYM+fk6+ZDcksXpKlsT5kt87hpdJUiw7AeH+cHAVW4K8v/bQuuUZJv1Qikxm
	 G/FDyT8SR1+6dcfFRA4L1FJmV6IQ5HVnyvCm6fDwv+LGkL2Wq9fvVq6GZGoxBnfU3Boup
	 RM44csWJmQjeloFQzWw64U89H9MLGchaM2+GBPYEDJcpGj1r6XZ+py1urbjM9DN8T4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263103;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=ScDNiRu1LhhAqGnssz6v8Goe18dHxFftj2LJPSqODSs=;
	b=KgmxfByXstQxZac6XX10sK5HMOMlOQsGOHHhsErwlZw5mCEW2T2aRfthvlRyyXzFmVVj
	 eq4jI+pjfWBkiNZIjJUDAlCy4P3ooi2VFxToTNc7vt+jivMM5c51q/kX1sHq/hhOsw/6G
	 qEF/SowlCL56sBHwodfwJhAecuCS9shwd1rj9OsEDrN9pvS7UeaQg3VGB2J6YG4AwQvWn
	 2XP1EE3r0MnbxHZsSz00a4EIWZ51Ge2B+06xA4H8DNhBbr8mhUP2lmzhwjlaMWpp171H2
	 b2s7eeRUcEF5EMRFF8wlqEAn+NX2wMhqRQUzcJtaMfoQpSTfCBfcXnOn1zOij+g/+YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE244606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE244606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-82274137201so2573330a34.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263102; x=1793867902;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ScDNiRu1LhhAqGnssz6v8Goe18dHxFftj2LJPSqODSs=;
        b=xxRwWkZYf96m8czni1sXLe1n9aaMv9FK8s0PS8EfLo5txY+IrdUWi5xgd/pZBAxWq5
         BVMv5FlIMZEGeGPjJdlLno3bZw9ybOxVUOWob0G4MqAa2HLLOacBi8xmR2KIhLfgdAkG
         dk0RGejF7s1Z6L4x1NzU0klDl97ARrZ477I+Vo/OrKs3dnyy9g2vdHKbS2YTPpGC64Ey
         WhT+8TG43IRoxNIhUKRgS9/uIvvmiyZmvsW6FxJvOQW4uf7EDAZLdBq/GhuGHHiUccin
         JHCS8Ra6d9rIbqXcuT8MRnwoD2dxA32+AShBrxHywWTicPxRda4A09KeM5fp8ce1smOA
         tZlg==
X-Forwarded-Encrypted: i=1; AKwUvBww6gt7QbsgyqGDsKf2oHNUF3ePXq93z2ZO+75ioIBEl3q3HmMzkqDu3oXbiCPvUd7OQyQIu6A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPRmE1/IfZXd6crBeYBJEkc9P4o/s2vy9Xrfi+3GgrC+wlZifZ
	LIMOJ3zneCFBcCRDk5Rk08wF8l8iIB3fjGLi2qMSuX/jbupzdhcSmQMY0DskGDqLBuYQd/+zNPr
	s0aF2akgWF1DmUdSBAokopQ7/JVyLnVkmhijzSP0WOoZK9FlOIWmtLe6TVmU=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83c5:20b0:70e:78ba:1192 with SMTP id
 006d021491bc7-713ed7bcb3emr1972000eaf.27.1793263101856; Thu, 29 Oct 2026
 01:38:21 -0700 (PDT)
Date: Thu, 29 Oct 2026 01:38:21 -0700
In-Reply-To: <20261028141751.6728-1-enderaoelyther@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae305fd.5451848c.f7707.0008.GAE@google.com>
Subject: [syzbot ci] Re: wifi: mac80211_hwsim: fix netlink release and radio
 removal races
From: syzbot ci <syzbot+ciaa26a4b0500f613c@syzkaller.appspotmail.com>
To: enderaoelyther@gmail.com, jlopex@gmail.com, johannes@sipsolutions.net, 
	jukka.rissanen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linville@tuxdriver.com, 
	stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] wifi: mac80211_hwsim: fix netlink release and radio removal races
https://lore.kernel.org/all/20261028141751.6728-1-enderaoelyther@gmail.com
* [PATCH 1/2] wifi: mac80211_hwsim: ignore non-generic netlink releases
* [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with frame commands

and found the following issue:
INFO: task hung in mac80211_hwsim_netlink_notify

Full report is available here:
https://ci.syzbot.org/series/fe9cfff2-ef52-45eb-993c-ea84c287686d

***

INFO: task hung in mac80211_hwsim_netlink_notify

tree:      wireless-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/wireless/wireless-next.git
base:      864c07de0c7dcbca58b61625dfa2e461ae63b242
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/ffa94119-c540-48f2-b244-f5fa2d9531b2/config

INFO: task syz-executor:21314 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22184 pid:21314 tgid:21314 ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 __schedule+0x17dd/0x5820
 schedule+0x164/0x2b0
 schedule_preempt_disabled+0x13/0x30
 __mutex_lock+0x7c4/0x15a0
 mac80211_hwsim_netlink_notify+0x193/0x1140
 notifier_call_chain+0x1a5/0x3d0
 blocking_notifier_call_chain+0x6a/0x90
 netlink_release+0x1211/0x1a90
 __sock_release+0xa0/0x1f0
 sock_close+0x1c/0x30
 __fput+0x408/0xa40
 fput_close_sync+0x11f/0x240
 __se_sys_close+0xa2/0x160
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed3715fd8e
RSP: 002b:00007fffadf594c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 000055557b013500 RCX: 00007fed3715fd8e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fed37f54670
R13: 0000000000000014 R14: 00007fed37f54864 R15: 00000000000001f4
 </TASK>

Showing all locks held in the system:
locks held by kworker/u8:1/13: 3, on CPU#0:
 #0: ffff888111e50148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc90000127c40 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffffffff9125a680 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x116/0x15c0
locks held by khungtaskd/35: 1, last CPU#1:
 #0: ffffffff8fd59ca0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180
locks held by getty/5413: 2, on CPU#1:
 #0: ffff88811659a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70
 #1: ffffc9000348b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360
locks held by kworker/u8:2/5484: 3, last CPU#0:
 #0: ffff88810b983148 ((wq_completion)krds_cp_wq#3/0){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc90004407c40 ((work_completion)(&(&cp->cp_conn_w)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffff88811a039280 (&tc->t_conn_path_lock){+.+.}-{4:4}, at: rds_tcp_conn_path_connect+0x1cc/0x920
locks held by kworker/u9:17/30931: 3, last CPU#1:
 #0: ffff8881000ac148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc90006befc40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffff888054278258 (&devlink->lock_key#13){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb30
locks held by kworker/u9:38/30947: 3, last CPU#1:
 #0: ffff8881000ac148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc9000765fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffff888075278258 (&devlink->lock_key#12){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb30
locks held by kworker/u9:39/30948: 3, last CPU#1:
 #0: ffff8881000ac148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc9000768fc40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffff88806cffd258 (&devlink->lock_key#5){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb30
locks held by kworker/u8:7/20795: 7, on CPU#0:
 #0: ffff8881012dd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc9000791fc40 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffffffff9124be48 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf5/0x810
 #3: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: hwsim_exit_net+0xc9/0xf70
 #4: ffffffff9125a680 (rtnl_mutex){+.+.}-{4:4}, at: wiphy_unregister+0x26f/0xb20
 #5: ffff888068390800 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: wiphy_unregister+0x279/0xb20
 #6: ffffffff8fd60328 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2cb/0x760
locks held by kworker/u8:8/20796: 2, last CPU#0:
 #0: ffff888113926148 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc9000793fc40 ((work_completion)(&(&bat_priv->dat.work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
locks held by syz-executor/21314: 3, on CPU#0:
 #0: ffff8881bfaa2640 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by kworker/0:5/21344: 3, on CPU#0:
 #0: ffff88810006ad48 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc90003ed7c40 (netdev_work){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffffffff9125a680 (rtnl_mutex){+.+.}-{4:4}, at: netdev_work_proc+0x6f/0x770
locks held by syz-executor/21396: 3, on CPU#0:
 #0: ffff888112f5c440 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21403: 3, on CPU#1:
 #0: ffff888013e16240 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21473: 3, on CPU#0:
 #0: ffff8881a662e240 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21500: 3, on CPU#0:
 #0: ffff88816a9b4440 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21503: 3, on CPU#1:
 #0: ffff8881a652ee40 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21537: 3, on CPU#1:
 #0: ffff8881bfaa5040 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff90a92d40 (hwsim_radio_mutex){+.+.}-{4:4}, at: mac80211_hwsim_netlink_notify+0x193/0x1140
locks held by syz-executor/21559: 7, on CPU#0:
 #0: ffff888117068460 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0
 #1: ffff888120412c80 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1d8/0x540
 #2: ffff88816bbcf4b8 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x22b/0x540
 #3: ffffffff90ad1400 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x13c/0x6d0
 #4: ffff8881c71ac128 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450
 #5: ffff8881c71a9258 (&devlink->lock_key#14){+.+.}-{4:4}, at: nsim_drv_probe+0xfb/0xbb0
 #6: ffffffff9125a680 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x257/0x2f0
locks held by syz-executor/21566: 3, last CPU#1:
 #0: ffff88819720ac40 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0
 #1: ffffffff912c9268 ((netlink_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x54/0x90
 #2: ffffffff8fd59ca0 (rcu_read_lock){....}-{1:3}, at: nl80211_netlink_notify+0x75/0x860
locks held by kworker/u9:0/21570: 3, last CPU#1:
 #0: ffff8881000ac148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #1: ffffc90003e87c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630
 #2: ffff8881bbf09258 (&devlink->lock_key){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb30
locks held by syz-executor/21598: 2, on CPU#0:
 #0: ffffffff909c0ba8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250
 #1: ffffffff9125a680 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc10/0x1c30

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 35 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150
 nmi_cpu_backtrace+0x274/0x2d0
 nmi_trigger_cpumask_backtrace+0x17d/0x390
 sys_info+0x135/0x170
 watchdog+0xfd2/0x1030
 kthread+0x38b/0x480
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 20796 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: bat_events batadv_dat_purge
RIP: 0010:native_apic_msr_write+0x39/0x50
Code: 74 2a 83 ff 30 74 25 eb 10 81 ff d0 00 00 00 74 1b 81 ff e0 00 00 00 74 13 c1 ef 04 81 c7 00 08 00 00 89 f9 89 f0 31 d2 0f 30 <66> 90 c3 cc cc cc cc cc 89 f6 31 d2 e9 e6 17 aa 03 66 0f 1f 44 00
RSP: 0018:ffffc90000007e50 EFLAGS: 00000046
RAX: 000000000000000f RBX: ffff888120e23f40 RCX: 0000000000000838
RDX: 0000000000000000 RSI: 000000000000000f RDI: 0000000000000838
RBP: ffffc90000007f10 R08: 0000000000000100 R09: 0000000000000001
R10: 0000000000000003 R11: ffffffff81758510 R12: ffffffff81758510
R13: 1ffff110241c47f1 R14: 0000000000000000 R15: ffff888120e23f8c
FS:  0000000000000000(0000) GS:ffff88818c4a4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f85c76b3866 CR3: 0000000169088000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 lapic_next_event+0x11/0x20
 clockevents_program_event+0x44e/0x630
 hrtimer_run_softirq+0x255/0x2e0
 handle_softirqs+0x265/0x8d0
 do_softirq+0x77/0xd0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x140
 batadv_dat_purge+0x2d7/0x3c0
 process_scheduled_works+0xc3d/0x1630
 worker_thread+0xa47/0xfb0
 kthread+0x38b/0x480
 ret_from_fork+0x514/0xb70
 ret_from_fork_asm+0x1a/0x30
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
