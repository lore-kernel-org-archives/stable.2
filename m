Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CE3DB626
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898117; cv=none; b=Of0EV/GG5Gh9qHqQEFM7Ti3nm+q4/I+PzGvtO8lf/pkDRaLdSLp9hfF9hcMWAX8FtjwzfkI6FyYO+GrcStY7Obe23st+vvEaz4NIV/wHmrHpA7/AKS4tyFwKphE9MPCxdF1wcrtrrL0B0Tgjmp3fPuZprRVe3N4Zja52VRzrwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898117; c=relaxed/simple;
	bh=k8FV0AuY/UnTXAbRfnvFY/B3Ch7+YNxyw8EB7UJBX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFWzU8KKEG9h17k8yXw3NaDEg1P+etybkY503uS8HqQh5pliTCVTLtqkr4hi1I8lo9PgVwnmIJAiBGhbRhyYeYhDNUe0rIa2MjgJS/GGV19n58yMd3ntePE/VrdGK8/EC12vX8qLzBItMXPhjd/NGyx8h5pxVhFN+SG8UgsvIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZSRXl+z; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZSRXl+z"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so5502715e9.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790898114; x=1791502914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x2eHfLXSxsUxHEfJdm6K8VExNqrOwW+s9I9FDdxMVoY=;
        b=GZSRXl+zGEAyAwjkC+sAg1bbC9dc5LWDmYkhWUK5/oaSl34zKmwHL0YNoO6SKjZpnc
         1wzQhpZFzfzdhl+lJiLpaPerEcRQLMfwOk7/3EFZ069BTQXPsJSEXTqTh0MZSRzpqhAx
         6fyuV6P0wl+pHC5bP/edM89m2Hlle5hqjMX4frLQg2FYE1ZMktpMnvN8pA1W3pZUZE8A
         3QBvGA7rHzgxVnCJ2kI4rLOHGGskGzqlpIo8h8pEGY5ZspNTYAV2iTdM+QRE4+rDKMr5
         C3ogMRhomK7JvZEg9eaLY03yKhcm9DVxrEs1fzZR+PtVbZQyFEbRnio11YAarX1Zs4+3
         Xbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898114; x=1791502914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2eHfLXSxsUxHEfJdm6K8VExNqrOwW+s9I9FDdxMVoY=;
        b=HAqSrzG/8vaG7N9GMgOEuSC5W6EI8PXelhKnmHqT+5L9fG008eRJH/gThj0A/IeOD8
         NBW+8C4Opl93hCy8bagECMqqXtDuv50eWQiEIggVsFg5c31SDrFA+KuTyxLUMJY6ff4v
         jv/aZ/ea7KUxKOMw0I/bRlv1WPgO+ewkMpzMCmgBlV+UCnkyl7Be0nDZD/PaJnNpSGzH
         qtYQNYrJA9lthWWuBSFVRiAnJDouAMK2EjG3PzHHd3wCx8IOdWzNzvLFltEbLyewpx7i
         XVC85Qj9J/7S9VfUBS+gccCiXnJMEPHpfKbdjgL5A40mvi7JsUPZ8dRaoz0OEaAJK45U
         wxuA==
X-Forwarded-Encrypted: i=1; AKwUvBzVgflMtD70MmA3IErit0hmOw3clkd/voCr87y14kmceSFctUGWwcFB6j8cgC9llefzo5Ic+so=@vger.kernel.org
X-Gm-Message-State: AFuF++lVdnqMjzhtku3LbH8iFZKxAn6HORQF5mywaEEJugTvd8TBePpT
	PgDxvoiDAIlYjY6ou13AzFCgkjd6gjgD5sINdxpKkmsY+ak/D/ex9xLz
X-Gm-Gg: AYBFou1RFmzfiv1rwBJPVm65iOGp6hbsrqkMpXSJIxm1VpLQ150Vkl1tkIWxJAYRsp2
	vCRbd8CXwN2qUD4EWwKrdiy1vgTMCjfls8TV0sacQVMURaKrfG5MtHlNQhexy/Pi5sVu2a9YV0G
	bq66UuFpiCHMV5L4YyGqSyu2yum5NJi/joXz38rsnzHo9fp3l3KbEtrBs1Jxgfu6ewse/KQoxXo
	eEeaOpSSVcd5ygpv+JT7vTFQnCSWk0H7En2hqgcDovkohAQj34cUqXbl+nvi7EEaflEYHVnpUeD
	XXE0AtfLsauzDK6OfFdso2yiao3jVa3LnQjZr/1IGxfPzH64abYbig3C77txFS/JwtyiLZj8aYm
	cBYBaDxAl3jQGMhCUDmHCOw5oqtVEXaio071oEIK/fgCYEsMK1+5aIl2K/Akc7ClkWlaaHPyZRc
	JFskfmQDWGmnEZNgBLDXLhHlFtHJQH74aoCTtooOru9LIR741Q5akb3Y+YVU7JBtGM5Wsp2xBiX
	FbYl2wqM29QAunsU+zBtFcdQIONWVMbWGbXrra/xyWfD9SAwnVzUI6JVLXMf07PCZOR/Sb+Yxvu
	skL853VSjw2pcTSF0s0kGF1bN89xn7tYWaDXMXz2KENKVoQeNBTyhosci45FQ5YheP5kXBxf9OV
	4PnXtRjeSNw==
X-Received: by 2002:a05:600c:620c:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a027583fb0mr16121105e9.20.1790898114308;
        Thu, 01 Oct 2026 16:41:54 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-b3ca-3a01-3deb-81e4-0dc4-fbe8.310.pool.telefonica.de. [2a02:3100:b3ca:3a01:3deb:81e4:dc4:fbe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280dc6e7sm30779645e9.15.2026.10.01.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:41:53 -0700 (PDT)
Date: Fri, 2 Oct 2026 01:41:51 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	g@mbp-von-karl.localdomain
Cc: linux-wireless@vger.kernel.org, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 contextg
Message-ID: <ar7vLt5kQ2HJoJY9@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261001075755.3MilPS2C@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001075755.3MilPS2C@linutronix.de>

On Thu, Oct 01, 2026 at 09:57:55AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-09-30 20:54:17 [+0200], Karl Mehltretter wrote:
> > This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
> > take the FWS lock first and need a separate change.
> 
> Is this the only affected driver?

I also reproduced a sleeping-lock warning with 8139cp on PREEMPT_RT
using QEMU's RTL8139C+ device. Enabling a dynamic netconsole target caused
the printer thread to enter cp_start_xmit() with hard interrupts disabled:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, pid: 107, name: pr/netcon0
  hardirqs last disabled at netpoll_send_skb+0x1c8/0x3d0
  rt_spin_lock
  cp_start_xmit+0x31/0x8b6 [8139cp]
  netpoll_start_xmit+0x18e/0x260
  netpoll_send_skb+0x37a/0x3d0
  netconsole_write+0x56d/0x820

That was one reproduction on the netdev base a7bfaba4823e. I have not
established how many drivers are affected.

Source inspection also identified 8139too and macb as candidates: their
transmit paths take ordinary spinlock_t locks. I have not reproduced the
warning with either driver.

The earlier netpoll/NBCON discussion concerns NAPI polling and
scheduler-lock deadlocks, rather than this driver-lock warning:

https://lore.kernel.org/linux-rt-devel/20260618111554.2n0pP_O9@linutronix.de/

> Do you have maybe a backtrace?
> 

This is the original Pi 400 report on 7.3-rc3 with PREEMPT_RT. That kernel
also had unrelated allocation-test patches applied. DEBUG_ATOMIC_SLEEP
was disabled, so this report is the BH-disable warning:

  DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
  WARNING: kernel/softirq.c:199 at __local_bh_disable_ip+0xd8/0x200
  CPU#0: pr/netcon0/769
  Call trace:
   __local_bh_disable_ip+0xd8/0x200
   brcmf_sdio_bus_txdata+0x90/0x2b0 [brcmfmac]
   brcmf_proto_bcdc_txdata+0x90/0xb0 [brcmfmac]
   brcmf_proto_bcdc_tx_queue_data+0x60/0xa0 [brcmfmac]
   brcmf_netdev_start_xmit+0x164/0x390 [brcmfmac]
   netpoll_start_xmit+0x160/0x218
   netpoll_send_skb+0x208/0x2b0
   netpoll_send_udp+0x298/0x478
   netconsole_write+0x440/0x7a0
   netconsole_write_basic+0x20/0x40
   nbcon_emit_next_record+0x208/0x2a8
   nbcon_emit_one+0xc8/0x110
   nbcon_kthread_func+0x184/0x210

Thanks,
Karl
