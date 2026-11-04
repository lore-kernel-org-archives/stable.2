Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793767877;
	b=ZhP02XCJybxhWXPsNz774OFU2dY/S/D/e4aeS7569DprBXtofs4JSdQaAP7qsmjU5lOk
	 oQJJJ+COYtrSnStoEfXdSLIYZ8Lb/vmCqiLK/T+x1e8oO05i9i1IJs7ozUg/bKW43I1CN
	 C2uBmzQUtEv2Qzs+WGifB3VRuMoJwGzRQgFm5dT8w87B6oTlYwakoU7nTdSpm8lksBtUw
	 m7NeFf7IZ5SV1C0LPrmN0b09cVkrGu44bHDaARr0cnzkyXYApfqfy4197UKa4aDcyn77F
	 EDc6i0/3QX3tB0cadFRH1IsbA7YMuSCsbQw5M9YtDAk0Tf00GCV3PQOv+48/S39BPFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mp8xsFriBqyXmCTwSHqo960HmvB3XMBtAen4xkqgSVo=;
	b=MxiCIh4q1LIwoue0i1VOc1HRRZliptS2i7YXZyva+rfZGZ0JuQF2BkWK/X08djxUqz/x
	 UnbtH8YNtOS1Au6u7ij3wntt4YZ9Vmnidwc4EZnVx2S5t68j/tWChySJ6NyNttzqp+fgA
	 GZxuDPf9D/V/hI3aF0DqxljhaRAcT4B4KUpT7hz3a4lwPCzucmL7jZ6xWz+DVuL3nP7KU
	 l6jia0DvXsLPntRrULTuWEjw+24lQp59AjppqaPSh0F48N3i5Ey/eK+hpN/KfEgxbtOOd
	 E5brDN8/F7W7fENhfd4dybA7DQf63YIVVxPcK/cxqt6aeG4lXyAqnB3qkncdSiQQl0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UAguqIPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484A606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 04:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C484A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UAguqIPl
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-170135e43c7so495652c88.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793767876; cv=none;
        d=google.com; s=arc-20260327;
        b=kU228845DMrrMtCAwhbTij7KYnqkaTuNrlqc/SePXIqA8TG2ldl8w87nv9Mq7tKnGE
         EgaLfKGnO0tYPfwVaXC40jJ/M46MMQas5oSHGnHaY8tYtyGIXoyTzpE0wRxCSc8r8bx4
         p9ESZCUhVsuzl7ZJC5NnHXuiUmq4iuEb94+A/bpAKzhvhcR1VUPb+qmleqGVy6I6h9Fg
         45hsJVXyPZEZM2u4rTvj+GfSnr+iwqtG1apdpurtcsbQpmNkTG5Zw14lEoAeDd9RrU2m
         tDAwN6t8XYQ4zqxm77T+zSXF02j1fr7fMHNAyM8l5fqgq0VQwWEQ58ExUK9SyuKWPAD4
         /Dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mp8xsFriBqyXmCTwSHqo960HmvB3XMBtAen4xkqgSVo=;
        fh=SAtK5x7W7UpeocWaYIRCSvI/aZGkpF3S/qLdDAaluyg=;
        b=f7e8BE92aJVpgMHLSO9wB9Raj8DxcSGsAGaRyqGIfTsEFrUi6Ifz1Hc4ibP/YTGmE8
         pUS0OyIzRzoQrzSo7Q9yb8cGx+SypOEzlaPh4P72xgOfz371gm7v841352pqH8j63xtB
         ifjAOPyD10hBxjRiQms9gvfSwXm2UFzOwR4JRQhAizwGDEOeMPAdJvos4YmrQTwC9VsB
         1lMTjOqJoULEy7xIjKCONai2LRc1smbdwmQKg8IG0KpfEEYTfP8r2vv1PjIhEefPImpH
         5Dx4N+jGt5lZ04gCwM3iRl0ADLmoX4+5yoSHl5Q0H/WBTwjQQwg119IIK76NRNNG9xiV
         p+WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793767876; x=1794372676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mp8xsFriBqyXmCTwSHqo960HmvB3XMBtAen4xkqgSVo=;
        b=UAguqIPle6zcUMb4YAD63PWBLz5jwb6dHVKUqYbn4e1cJXWj2CFq/40p0V+SKk3GCb
         LpxfANox8Sxh2upFoUm5uUP7zd5OtCQenbdo45g0ZWLNAl7eoFVsVNlRNjAmTA2XOT4l
         t/gARt//D7ed3JdNS+MbiDAcoRUCivKSngGseqWi4JneUVEDGjVAUoqPe1ZYWyvARc5e
         UOu9FfaCyAUbxmX5BQRLoMJ4ybYbL7z2KisICvRoor4T4AkNiTSnrPmodlbRHKlXKbLx
         pkqw4hx7OQFemiBmE6gjgcWs+euiA5E6jZtZIHSzoa4+I1UEC7j7P90EQa7zOLHyPQxS
         xinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793767876; x=1794372676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mp8xsFriBqyXmCTwSHqo960HmvB3XMBtAen4xkqgSVo=;
        b=lFgpjp1kC2zvP2CkiX4EdOb3OArUZhMcSegGKl69Cz6Mhd0UmLzvLf5JChmeuC+mha
         DNjWWSFLlcqxEdBf0r02K2tLx6AN9navmkCpuhouCNKuasw+4jCWLyF4yqVlTyEZXfNo
         4vNQH0F8gWZ5APCmdWBWUrpDholpFvlcC/1BNd71v9wEzBWkyW0jqN/xY/3BTMU/eDJD
         5Ap2bUdU2NfHNeyrnVS/wK7o8GSPGi24s3RL3gMx+2WmlTbHB/FDvDe4FTHv0M7euClL
         pzJ3IKICwYtClVTbUmnopK27aTSpJRNjK/8q6OA6kLcXBUumvmxjyOUDBACvlaoZgaXz
         GlOg==
X-Forwarded-Encrypted: i=1; AKwUvBzMB0eGUJDWYzF601aevv9S4bPQv3YOZEvRU6r1163Ubh7EDO4jt5EYGK4lf+gPlJbff4kvF3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FEui+fUY1gWoZVSSU13sQ8L2wyzQ3Fsq5mrS5pBfSYZihiLJ/
	Uqi+xY9jPgW2XOnpmDSb9359GLPNQ+b5YtIidiNpMEMLicFzoUPOgntsFJl4wEkxb5E/R8bpgZd
	++EeFJc2s1qQdKQ+qMCxp6tYN4ANbWmVPqSN40wkw
X-Gm-Gg: AYBFou0wwNGAUfWCL8DVqgsTvNl2Cvx8kp0X+ktwGbp70sI/O1ljhefsZJsZgHFY2D7
	V98spK+60/+KrVTlPy/ZcxKZlspCGjmfGWD04Mp/fxWzFXRaxyj+paHXJijAgKuKGGdgaeMFuPt
	wqDSY0hBGVWZvutzBXgj+VOPQaR8mmJav4lxyCnrthxyVaUKZj3R/bILwRvYibcxeJtrkdnGzj+
	AprbGPCSV5iR6qJ6SyuA27ICJTtt/cwlf2ZSh1Sfae6V94YAhVVYa3f0hGOgiNrVLp6LnJmq8G5
	Wx9uV25nlhqOsrRdxFVkQFVPR8zr90GqQkxU5fw1REx+8nu0jm+k0/NCVQoi0Z1A9y60fOlqP/g
	1qEEODWUkJT0GlV+v34AfSYFPNzKtOslF6ffkqxGS5VVrjkEXl9pfykp3uN6ui2e0T+kt2acRy6
	hLCO8aDnr+cpgRr8G7
X-Received: by 2002:a05:7022:7f12:b0:1ab:faad:cc9 with SMTP id
 a92af1059eb24-1ac5bbb503dmr23077930c88.11.1793767875002; Tue, 03 Nov 2026
 20:51:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103042210.2984373-1-bcochrane@google.com> <179376630095.488856.6614017924619723779@kernel.org>
In-Reply-To: <179376630095.488856.6614017924619723779@kernel.org>
From: Bryan Cochrane <bcochrane@google.com>
Date: Tue, 3 Nov 2026 20:51:02 -0800
X-Gm-Features: AclHuK9J1H0G53iFpSG9-VmpGKScwgpb_eB7c9i3tFYXGIKtJDzmkDwUVeNsWY8
Message-ID: <CALuKKxG_j11CcA7ZEr9AashVAvtcRQCbramLXFxCW9QpqWQ4nA@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
To: netdev-bot+sashiko@kernel.org
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	joe@dama.to, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Nov 2026, <netdev-bot> wrote:
> - [High] New deadlock in bnxt_fw_reset().
[...]
> CPU1
>       rtnl_lock();
>       netdev_lock(bp->dev);
>       netif_close(bp->dev)
>         bnxt_close()->bnxt_close_nic()->__bnxt_close_nic()
>           while (bnxt_drv_busy(bp))
>               msleep(20);
>
> bnxt_drv_busy() tests BNXT_STATE_IN_SP_TASK. Normally only the sp_task
> clears that bit, and the sp_task is the thread stuck in this loop.
>
> Would this spin forever with rtnl_mutex and the instance lock held?

Yes, this is a valid finding, thanks. bnxt_fw_recover() can enter
bnxt_fw_reset() from the devlink health recover path as soon as the
reporter is in the error state, and bnxt_unlock_sp() then sets
BNXT_STATE_IN_SP_TASK although the caller is not the sp_task. Before v2
the instance lock was held across netif_close(), so this could not
interleave; the unlock/relock window in v2 makes it reachable, and the
thread that would spin in __bnxt_close_nic() is the sp_task itself, so
nothing would ever clear the bit.

v3 will not drop and retake the locks in bnxt_fw_reset() at all. The
bnxt_get_registered_vfs() failure sets fw_reset_state to
BNXT_FW_RESET_STATE_ABORT and queues bnxt_fw_reset_task(), which then
performs the abort through the fw_reset_abort path that already takes
RTNL before the instance lock. bnxt_fw_reset() keeps the instance lock
from bnxt_lock_sp() to bnxt_unlock_sp() as before, with no netif_close()
in it.

The unconditional set_bit(BNXT_STATE_IN_SP_TASK) in bnxt_unlock_sp()
when bnxt_fw_reset()/bnxt_fw_exception() are entered via devlink is
pre-existing and not specific to this fix; I'd rather address it in a
separate patch.

> [Severity: Medium]
> This is a pre-existing issue, but this path returns without calling
> bnxt_ulp_start(). Nothing undoes the bnxt_ulp_stop() at the top of
> bnxt_fw_reset(). Does this leave the RoCE/aux driver suspended after the
> abort?
[...]
> Since this path is being rewritten anyway, could the ULP be restarted her=
e
> too?

Agreed. With the abort routed through bnxt_fw_reset_task() in v3, rc is
0 at the ulp_start label and bnxt_ulp_start() runs, the same as for the
POLL_VF abort.

> [Severity: High]
> This isn't a bug introduced by this patch, but commit 004b5008016a seems
> to have left one more netif_close() call without RTNL that this patch doe=
s
> not cover. bnxt_vf_reps_destroy() holds only the instance lock:
[...]
> If this patch is backported to stable on its own, this site from the same
> Fixes commit would still be there.

Agreed that bnxt_open_nic() -> netif_close() under bnxt_vf_reps_destroy()
has the same problem, but it is a different call path (devlink eswitch
mode change and SR-IOV disable) with its own locking context, so I'd
prefer to keep it out of this fix and handle it separately. The two
fixes can be backported independently.

> [Severity: High]
> This is also a pre-existing issue, but the same netif_close() without RTN=
L
> looks reachable through the TPH queue restart path. bnxt_tph_update()
> runs from bnxt_sp_task() under bnxt_lock_sp(), which takes only the
> instance lock:
[...]
> Can this trigger the same ASSERT_RTNL() warnings when the HWRM calls fail
> on unhealthy firmware?

Also pre-existing and known: the netif_close() in the bnxt_queue_start()
error path was added by commit 325eb217e41f ("bnxt_en: bring back
rtnl_lock() in the bnxt_open() path") precisely because that path does
not hold RTNL. It is outside the scope of this patch.

pw-bot: cr


On Tue, 3 Nov 2026 at 20:25, <netdev-bot+sashiko@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 (2) =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] New deadlock in bnxt_fw_reset().
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the same Fixes
>   commit (004b5008016a) left another netif_close()-without-RTNL site=E2=
=80=A6
> - [High] This problem wasn't introduced by this patch, but the same
>   netif_close()-without-RTNL bug is still reachable through the TPH=E2=80=
=A6
> - [Medium] This problem wasn't introduced by this patch, but the
>   bnxt_get_registered_vfs() failure path in bnxt_fw_reset() leaves the=E2=
=80=A6
>
> --
>
> bnxt_en: Take RTNL before netif_close() when aborting FW reset
>
> This patch takes RTNL before the netdev instance lock on the FW reset
> abort paths in bnxt_fw_reset_task(). It does the same on the
> bnxt_get_registered_vfs() failure path in bnxt_fw_reset(), so that
> netif_close() runs with RTNL held. The goal is to fix the ASSERT_RTNL()
> warnings introduced by commit 004b5008016a ("eth: bnxt: remove most
> dependencies on RTNL").
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 33c4cacc8ffe3..1ea1e8266eabf 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -14860,9 +14860,16 @@ void bnxt_fw_reset(struct bnxt *bp)
> >               if (n < 0) {
> >                       netdev_err(bp->dev, "Firmware reset aborted, rc =
=3D %d\n",
> >                                  n);
> > +                     /* netif_close() requires RTNL, which must be tak=
en
> > +                      * before the netdev instance lock.
> > +                      */
> > +                     netdev_unlock(bp->dev);
> > +                     rtnl_lock();
> > +                     netdev_lock(bp->dev);
>
> [Severity: High]
> Can a concurrent devlink health recover hang the sp_task here while it
> holds RTNL?
>
> bnxt_sp_task() is not the only caller of bnxt_fw_reset(). When
> devlink_health_report() returns -ECANCELED,
> bnxt_devlink_health_fw_report() calls __bnxt_fw_recover() from the sp_tas=
k
> without the devlink lock.
>
> At that point the reporter is already in the error state. A userspace
> "devlink health recover" can then reach bnxt_fw_reset() through
> bnxt_fw_recover() at the same time.
>
> Before this patch the instance lock was held all the way through
> netif_close(). The new unlock/relock window seems to allow this ordering:
>
> CPU1 (bnxt_sp_task)
> bnxt_devlink_health_fw_report()
>   __bnxt_fw_recover()
>     bnxt_fw_reset()
>       bnxt_lock_sp()          /* clears IN_SP_TASK */
>       set_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
>       bnxt_get_registered_vfs() returns < 0
>       netdev_unlock(bp->dev);
>
> CPU2 (devlink health recover)
> devlink_health_reporter_recover()
>   bnxt_fw_recover()
>     __bnxt_fw_recover()
>       bnxt_fw_reset()
>         bnxt_lock_sp()        /* now gets the instance lock */
>         IN_FW_RESET is set, nothing to do
>         bnxt_unlock_sp()
>           set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
>           netdev_unlock(bp->dev);
>
> CPU1
>       rtnl_lock();
>       netdev_lock(bp->dev);
>       netif_close(bp->dev)
>         bnxt_close()->bnxt_close_nic()->__bnxt_close_nic()
>           while (bnxt_drv_busy(bp))
>               msleep(20);
>
> bnxt_drv_busy() tests BNXT_STATE_IN_SP_TASK. Normally only the sp_task
> clears that bit, and the sp_task is the thread stuck in this loop.
>
> Would this spin forever with rtnl_mutex and the instance lock held?
>
> CPU2 can wait on netdev_lock for the whole time the func_qcfg HWRM call i=
s
> timing out, so the window may be wide.
>
> The commit message says:
>
>     BNXT_STATE_IN_FW_RESET stays set across the lock switch, so a
>     concurrent close marks the reset aborted as it does today and a
>     concurrent recovery request backs off.
>
> The back-off path goes through bnxt_unlock_sp(). Isn't that the code that
> sets the bit causing the hang?
>
> It is older behavior that bnxt_unlock_sp() and bnxt_rtnl_unlock_sp() set
> IN_SP_TASK no matter who the caller is. The comment in bnxt_lock_sp()
> assumes the caller is always bnxt_sp_task(). The new window is what makes
> the problem reachable.
>
> >                       clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
> >                       netif_close(bp->dev);
> > -                     goto fw_reset_exit;
> > +                     bnxt_rtnl_unlock_sp(bp);
> > +                     return;
>
> [Severity: Medium]
> This is a pre-existing issue, but this path returns without calling
> bnxt_ulp_start(). Nothing undoes the bnxt_ulp_stop() at the top of
> bnxt_fw_reset(). Does this leave the RoCE/aux driver suspended after the
> abort?
>
> The old goto fw_reset_exit had the same problem. Neither bnxt_close() nor
> a later bnxt_open() resumes the ULP.
>
> bnxt_hwrm_if_change() only queues BNXT_RESTART_ULP_SP_EVENT when
> BNXT_STATE_FW_RESET_DET is set. That won't happen if the func_qcfg failur=
e
> was transient.
>
> The matching abort for the POLL_VF state in bnxt_fw_reset_task() reaches
> ulp_start with rc =3D=3D 0, so it does restart the ULP:
>
> ulp_start:
>         if (!rc)
>                 bnxt_ulp_start(bp);
>
> Since this path is being rewritten anyway, could the ULP be restarted her=
e
> too?
>
> >               } else if (n > 0) {
> >                       u16 vf_tmo_dsecs =3D n * 10;
> >
>
> [ ... ]
>
> > @@ -15682,9 +15688,11 @@ static void bnxt_fw_reset_task(struct work_str=
uct *work)
> >               netdev_err(bp->dev, "fw_health_status 0x%x\n", sts);
> >       }
> >  fw_reset_abort:
> > +     rtnl_lock();
> >       netdev_lock(bp->dev);
> >       bnxt_fw_reset_abort(bp, rc);
> >       netdev_unlock(bp->dev);
> > +     rtnl_unlock();
>
> [Severity: High]
> This isn't a bug introduced by this patch, but commit 004b5008016a seems
> to have left one more netif_close() call without RTNL that this patch doe=
s
> not cover. bnxt_vf_reps_destroy() holds only the instance lock:
>
> drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c:bnxt_vf_reps_destroy() {
>     ...
>         netdev_lock(bp->dev);
>         if (netif_running(bp->dev)) {
>                 bnxt_close_nic(bp, false, false);
>                 closed =3D true;
>         }
>     ...
>                 bp->eswitch_mode =3D DEVLINK_ESWITCH_MODE_LEGACY;
>                 bnxt_open_nic(bp, false, false);
>     ...
> }
>
> bnxt_open_nic() calls netif_close() on any failure. That includes the
> immediate -EIO when BNXT_STATE_ABORT_ERR is set:
>
>         if (rc) {
>                 netdev_err(bp->dev, "nic open fail (rc: %x)\n", rc);
>                 netif_close(bp->dev);
>         }
>
> There are two callers, and both hold only the devlink instance lock:
>
> - bnxt_dl_eswitch_mode_set() for DEVLINK_ESWITCH_MODE_LEGACY
> - __bnxt_sriov_disable()
>
> Wouldn't this hit the same ASSERT_RTNL() in __dev_close_many()? Wouldn't
> it also run the NETDEV_GOING_DOWN/NETDEV_DOWN notifiers without RTNL?
>
> If this patch is backported to stable on its own, this site from the same
> Fixes commit would still be there.
>
> [Severity: High]
> This is also a pre-existing issue, but the same netif_close() without RTN=
L
> looks reachable through the TPH queue restart path. bnxt_tph_update()
> runs from bnxt_sp_task() under bnxt_lock_sp(), which takes only the
> instance lock:
>
> bnxt_sp_task()
>   bnxt_tph_update()
>     bnxt_lock_sp()
>     netdev_rx_queue_restart()
>       netdev_rx_queue_reconfig()   /* only asserts the instance lock */
>         bnxt_queue_start()
>
> bnxt_queue_start() closes the device on its error path. This happens if
> any of these fail: bnxt_hwrm_rx_ring_alloc(),
> bnxt_hwrm_cp_ring_alloc_p5(), bnxt_hwrm_rx_agg_ring_alloc() or
> bnxt_tx_queue_start().
>
> err_reset:
>         netdev_err(bp->dev, "Unexpected HWRM error during queue start rc:=
 %d\n",
>                    rc);
>         napi_enable_locked(&bnapi->napi);
>         bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
>         netif_close(dev);
>
> Can this trigger the same ASSERT_RTNL() warnings when the HWRM calls fail
> on unhealthy firmware?
>
> >  ulp_start:
> >       if (!rc)
> >               bnxt_ulp_start(bp);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261103042210.2984373-1-bcochrane%40google.com
