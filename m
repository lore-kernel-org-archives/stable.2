Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672087;
	b=mwl5QysoO4WOUy6a6cYQVj165SibyhoaTK1U1uZExwrh6rojYRYny+VxRlPjpaFOvdhb
	 MEGKgKH4MviDDpuT5nPuRTXI5RU0ZTmqcBLSlk1zmroyy8cHg9x51cvncBrik1u2beFJc
	 zLESEHf+HTeWFMCdhAmFZaVuKp1xAYkd/bxgZEGxp8NAULzYEeGqDbuDSRxx0F0JCrZ8n
	 zrj+ABzAFpkwR6+Ex04+99dSQuLWJR/QNBdS5Mca18Z6USuO8LEDwtNliKpD+y2MtlFKR
	 9LPxMNeyHtOPM+W1IrhP/vpmRlvJUIU3TNX9xN9jhWrNJTOOOgPP6+qVh+Jcs6AAARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672087;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lXjrs8f+clHxHRmAHHDyG2Qp+kvOK2dL/fxV7v8HJ1Y=;
	b=jTWTRfkisL3VxPqVK/5h4OInME+8RH4+eCR0fOFA/OKzU6HShHD8l3uGf8BCVo+HtYqS
	 ZdVGGLOs96uXdyrN/veWTA880jqHQKRrHc3BQddo3YyLXc5dzMYIW07PupTe3aY9jy+kC
	 UsrFywJ25ySeIFFzfU0mcr5u04qd5V7NMZYIV7v4Q96X/0siWrmXZuYT1cvSi96NcwvYI
	 M/X0kuXtg09JJ090Xqe33549ByhMhXEWoYx2EKWpktToumQUU53JZMsES0hXtmPwSAJIh
	 x0jkLEOo1wUQIDW2uUi3gzcc/UTv4RD/IFci3C9ee9/RRWEmGlCaxkA/+rTdhd7ijWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PO8hZQCD;
	arc=none smtp.remote-ip=203.205.221.221
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DA606A319;
	Thu, 22 Oct 2026 12:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 355DA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PO8hZQCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792672076; bh=lXjrs8f+clHxHRmAHHDyG2Qp+kvOK2dL/fxV7v8HJ1Y=;
	h=From:To:Cc:Subject:Date;
	b=PO8hZQCDxLBTBXqUsewZMg3wD1WaxR4IrpzcdpEQpiAWVD1joBjBph2IpNVj2eOXp
	 wFcC4skpYgwmBvTRUhxaPlRKJxtZe1sh8X2Gjr+SzhYawdwz54k1p0MtLeNGlYyuAY
	 VL5ZMyP/flzg7pcnmptIXrZfZ14GONebrgdlsyr4=
Received: from kernel-lab.tail5e91bb.ts.net ([2408:8352:460:ee50:a639:b3ff:fe5f:1b0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6F5AF60A; Thu, 22 Oct 2026 20:27:53 +0800
X-QQ-mid: xmsmtpt1792672073tujq29upg
Message-ID: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
X-QQ-XMAILINFO: Nwte6vbuj0EqxgX4ct9MTeweSfBeAP6jPOrYZx6+tqR4TpE6xdykJeSAdiFLhK
	 4/pF6hLz2OoGNibcalMhcvvl1F06l40xWqCm+87wIPUSuyXrN/cDUaj1ooF5F2ciQcyfR0C817Oi
	 JIt7KVoCgMCkEMOuVl3JVIk7+N2Pg+T0DByBuqqgEAWr1gYRYTANapAExoBUDFF3o4i4PvKfzVKH
	 37yj3qXKszg/zOXFrJ323tM2MgB88EAF3g4zlpXLjCz26zA60DXxT4Xrg9TqfGauTP2k1gZvG0Ie
	 sbx4YD3hQUBZXR67YQ+E0fHkhGK4JsiJfMVqJLY7WtPg5Cns17kyskybjnH4Ls++YMPIO2v0D3r1
	 pWUVmSdMZeJomUdYagEm2AOwy2fxjE0ltLDX4yisBIik6qJpDi4XOz8cAa69IsL+Lcp1cWoUfxE6
	 JIXKlVN93GGpmaP4mKDfay37WJulTLFCACCrYJRgfb2FK8y/xpSgnp9oy4ZlZZBlHYp/xFYdfs+n
	 ajWI5hJAsN1k1aUeqejMZw5DZqVN+eu8lFXbLMSCScEXJMmlVG22OWlH4bKkgYYQLP1AbzD4pJBR
	 5BASe9kFTLi01GrDUl0+q7fLHbmncH/EoR6SqRkkeShSfGPAfDzu28FRI9x+A9BPHBg1Plo7eOkK
	 UAsSksTyUx1ZXSTsmIDboT9gycamBB58Qqa8nNQYwJW+vETotA/PbWQohYBHEJbhhO0ljDfUJaeO
	 C4AkD8ni072i/NPypDQtfhbkpWH3E0ZOrYaCEPshD/jt5czyveEGBGijfiscw7nCG6169oXCz66s
	 8TnRJRfiTcoc8ig9peqqwI3GflbE5FOPwPAbZQ6cb1HErGDU0IGNInWxMCOBhY6emFu5yv0PuT2S
	 7U4yhv6gMrskeoI5Es0LdB+nIliWtCoQ+D4+Bh9Q2+PXaZzi/CIfXpfd7QGM86dpOSa7uboTq6sy
	 NsvLnAJkQMeSwmlROlXOYHmsvxnAqSVAUkf8sow2b8egCGdWCtwDmvMQJuObEpJjtZJrC2UI2XrM
	 MdHpMi5sQMo8ke4gCDew5VtKQhVWjfgJGQzs/urzLENUhwPJzeyp8pguOFS8k=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yingjie Wang <1075151112@qq.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: limit tcp_tso_rtt_log to a valid shift count
Date: Thu, 22 Oct 2026 20:27:52 +0800
X-OQ-MSGID: <20261022122753.625855-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
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

tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
an upper bound, so it accepts values through 255. Values above 31 make
the shift undefined.

A process with CAP_NET_ADMIN in the target network namespace can set the
per-netns sysctl. With CONFIG_UBSAN_SHIFT=y, setting it to 32 and sending
TCP data over loopback triggers:

  UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  Call Trace:
   __ubsan_handle_shift_out_of_bounds
   tcp_tso_segs
   tcp_write_xmit
   __tcp_push_pending_frames
   tcp_push
   tcp_sendmsg_locked

Limit the sysctl to 31, the largest valid shift count for a u32, and
document the accepted range. Writes of larger values now fail with
-EINVAL.

On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
valid boundary values produced no sanitizer diagnostics.

Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 Documentation/networking/ip-sysctl.rst | 2 ++
 net/ipv4/sysctl_net_ipv4.c             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 8edd2eb2a..66a54c510 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1128,6 +1128,8 @@ tcp_tso_rtt_log - INTEGER
 
 	If you want to use the old autosizing, set this sysctl to 0.
 
+	Possible values are [0, 31], inclusive.
+
 	Default: 9  (2^9 = 512 usec)
 
 tcp_pacing_ss_ratio - INTEGER
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3..e95431140 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -26,6 +26,7 @@ static int ip_local_port_range_max[] = { 65535, 65535 };
 static int tcp_adv_win_scale_min = -31;
 static int tcp_adv_win_scale_max = 31;
 static int tcp_app_win_max = 31;
+static int tcp_tso_rtt_log_max = 31;
 static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
 static int tcp_min_snd_mss_max = 65535;
 static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
@@ -778,6 +779,7 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.extra2		= &tcp_tso_rtt_log_max,
 	},
 	{
 		.procname	= "ip_early_demux",

base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
-- 
2.43.0

