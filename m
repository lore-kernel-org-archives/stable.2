Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492528;
	b=Zf0/u0wE3AzfE0RMEHW3AbXIb+yo5TCl/9bIJu0omNWGdEHL+12zyjSPMfThTA9bgWFL
	 SqnfQ52eF7a+wXBshuRIkh24+5E3PMLD6gOCZp5+o1CCzqCsKttzmuneZTgcOXPGQ13tc
	 rPTTuEGUDKU6xeA7Mcu7u5W/BDg+APnuEGJBFS1Dv8tHZrddURYIFE0YCmW9rx0Q9nYTD
	 JjWcZtgQmRqu6XQNqcyOwhxvPtSXqGVQEQEcPG3WVLcLQfKEQSKiGGg0Pl57yy1+SKgo+
	 TlHruuc5INDH3EhCF6dcNStaDxhGi2M5x15XC2Kyov15yOQr1vxn9PI3nkqKak05VSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
	b=KW6noPbV39pplGZZHysvn1phXzs/X/dxCLrIlh1LHNRoiDh7dM9o27eZGza9QVl1Rfpl
	 YeB3+sW9uGftGjzvUnCQVDRxjPPUjUtBfUdkqJNmGg/Ni76Lm5kI9V/OkQvPRH1TH/k0C
	 3YDykv1oetBbemSFpLwn0C4WI0qQumlCCRU8Pa0G+Z5TEGsXu7v+So671F9cUz30B5k0P
	 p1akri1Y/yPh0aNO/91Hg6g24QaGbM2DmCZFGt7RI2jFN4c0vwmiqMG0oAIzPeLo1wxs4
	 Fx5qbLQOCRvAjz6T7Gmdl25CasNLDuM9wl1octdfp5vcZGwgvfyCqk/k29/9amDA05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tfy8gPpg;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E66606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6E66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tfy8gPpg
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c413dea9ca6so476489266b.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792492526; x=1793097326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
        b=Tfy8gPpgNea4NWmTe/7uKj8VWr03aU0uep+R7u3EFHcdUFS3ae+coI/B/Hu3NW78CT
         y/GZGFdeUTthHmMrLVJpyb/zB/r4//qrjlRALruWMwv0M1SzyvyrhWc7grCEz1dnNnhi
         tjeLbdjlPXE7NqLWScuqc3+OfFtRubc7ukA+lUkYNxyqZ+Hj9HkupJjDRflce8aUJBuB
         wkX8xo5uJOktCCHq9WcXGb5wf/9aI1Uio7EBxdeo37XyAJuGLw0btJme7AOZv4iQrQ2u
         COI/cssbwIY9TtKbVd+2oS8KG+8xAcJrqb3Tj9iT65FxEaCV/PLkyfddaxYrw44i94hU
         uFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492526; x=1793097326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6vl8DhBKNBBeDdXDarV+k7b4TukYYKqz3C8gKFsMSM=;
        b=GKsr/Z3fXb5hrAABNb9ZXbcUIcr4gwXRAhHvu932BlVtJQcPBnCSuvPRKPpRUXKXm8
         0hdql1Vj88ybOFB6V4In+pbY1UAJgTVI5SRIG0Y0b/zV4kuMd2/1qFltvsHfEVxkmYxq
         tOfzQjuejhQ6yZRDrV4QXQFHfux8h0nDTH53aUBdBv1bO40P9j7gbEAcY7XhNxcgzaVM
         cyKuqLaKKv4+CHNc5n7AKR/lGwXhgBWh9sfcGvpQ8p5w/WCfZUSlNfsX9mJ9qoxrHTxz
         3bankIpb1Izg9yvTH9LJfodgXGsReiviihxCTeE4EgZ72QZTCors7i4Gwovn06FNeb75
         kgYg==
X-Forwarded-Encrypted: i=1; AKwUvByXhbweKbAE4LjMCQ+7O2TC6lfICeNDkbyuy+lNKc4104oPRfGbNgEz5k6WluX9EvavhC/C0AQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIruBX8cP8FrfA4kxxbS75JE3FrP2xJbnJql3bMSd474FnIG/KY
	7iLDEAyBMle0dybJ4GbuhZ/QJIkU8BxN9eC15v8W7u2WHp+YKqgmFXGJ
X-Gm-Gg: AYBFou3rpncMvEG9N7kHh6NA5Mv4PuJ91zXb0Jjhby43nkmRHPKPyFALzfe8Ex/T/2T
	XHvPIOTFHbPuf9wwX7Iz3z67XEzU/6NBywDWQ5Hgfmc4Xt/GRqMlmMAu21ogNCPKveYdXUbQWzl
	Mv4N/Ek/CfKH6vxSSV9RUOx5RmllqSyw6p1zCDggEAaeckI4UAOMEyP7/qS/UYXmxs0di9+z5+w
	OzwButgh68aOQPyePyx/d/DohnWSl5rME078dOETjeR7PXP1C/jw2gk3id9ZuIHCVf2B/8bzf3p
	JYbXhNxhOUwdPl4o3WHonihPMwlUvPb+Pz4SWAqx8amZmm8xoGmQuuUKYBa7sZAKh6dIp6rRfCt
	rEADEKHqcPhBmqUeRiAWvRss098XVGR1ymIU7JlQt79vQ5OtCYtD2B2gPdCOyhaLeX/b02h9g1e
	5Out4wlKYPmGpHBMxkRQn3kOe/dPLnLFicvlWjY5GzrbEpTqN5o5koXi3Agef02TKZi7TRAfzZu
	5Lv59BlVZg/3wqwCYRTDatJ6NnJWcCh7ktHfF2DMAhj+bAX3VYEQAYPPzkxTiQrX6H0CIUfNXy/
	IJSrRCDazgD1jsEZJR7MNf722ihFsQ==
X-Received: by 2002:a17:907:60c8:b0:c43:a881:3f4b with SMTP id a640c23a62f3a-c43a8814361mr595412366b.47.1792492526023;
        Tue, 20 Oct 2026 03:35:26 -0700 (PDT)
Received: from localhost.localdomain (ip-80-113-117-72.ip.prioritytelecom.net. [80.113.117.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bcae3sm479893666b.57.2026.10.20.03.35.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 03:35:25 -0700 (PDT)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: extend ct timeout of offloaded GRE flows
Date: Tue, 20 Oct 2026 12:35:20 +0200
Message-ID: <20261020103520.76439-1-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Since commit 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn
timeout extension logic"), the flowtable gc worker extends the timeout
of an offloaded conntrack entry from nf_flow_table_extend_ct_timeout()
once it falls below 5 minutes. That function only knows about TCP and
UDP and hits WARN_ON_ONCE() for any other layer 4 protocol. However,
GRE flows can be offloaded too, both via nft_flow_offload and act_ct,
since commit 4e8d9584d154 ("netfilter: flowtable: Support GRE").

The timeout of an offloaded GRE entry drops below that threshold as soon
as a packet of the flow still goes through conntrack. With ip6gre
tunnels using the default encapsulation limit this is ordinary traffic:
the flowtable does not parse the Destination Options header in front of
GRE, so every packet of the flow takes the classic forwarding path. It
also happens for a packet with ttl <= 1, which the flowtable fast path
passes up to the classic forwarding path. nf_conntrack_gre_packet() then
refreshes ct->timeout to the GRE stream timeout (180 seconds by default),
and the next gc run triggers, as reported by syzbot:

  WARNING: net/netfilter/nf_flow_table_core.c:553 at nf_flow_table_extend_ct_timeout+0x1ee/0x2f0
  Workqueue: events_power_efficient nf_flow_offload_work_gc
  Call Trace:
   nf_flow_offload_gc_step+0x545/0x7b0
   nf_flow_table_iterate+0x13c/0x1f0
   nf_flow_offload_work_gc+0x22/0x70
   process_scheduled_works+0xc3d/0x1630
   worker_thread+0xa47/0xfb0
   kthread+0x38b/0x480

Besides the splat, which panics the machine with panic_on_warn, the
default branch sets the new timeout to 1 jiffy, so the conntrack entry
expires right away and the offloaded flow is torn down.

Handle GRE like UDP and extend the timeout to NF_CT_DAY. GRE conntrack
has no protocol state to take into account, and NF_CT_DAY is also what
flow_offload_add() already sets for every offloaded entry, GRE included.
This also restores the behaviour from before commit 03428ca5cee9, when
the conntrack gc worker extended offloaded entries of any protocol to
NF_CT_DAY.

Fixes: 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn timeout extension logic")
Reported-by: syzbot+521f7e7e2b974abde99a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=521f7e7e2b974abde99a
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
Tested on v7.3 in QEMU, with and without KASAN, lockdep and
DEBUG_OBJECTS, using netns topologies where a router namespace
offloads GRE flows to a flowtable:

 - nft "flow add" and tc act_ct, each with IPv4 GRE and ip6gre
 - ip6gre with the default encapsulation limit (plain pings), and
   ttl=1 GRE packets for IPv4
 - 120s stress runs: 6 GRE tunnels plus TCP/UDP traffic, ttl=1
   packets, flowtable deleted and re-added every ~20s

Without this patch every run hits the WARN above and the GRE
conntrack entries are torn down and recreated over and over (hundreds
of NEW events in the stress run); with panic_on_warn=1 the kernel
panics. With it there is no WARN, GRE entries stay offloaded with a
~1 day timeout, and TCP/UDP behave as before. The nft_flowtable.sh,
nft_offload.sh and nft_interface_stress.sh selftests give the same
results with and without this patch.

 net/netfilter/nf_flow_table_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 36bbc7be2f..94502c97ba 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -544,6 +544,7 @@ static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
 
 		switch (l4proto) {
 		case IPPROTO_UDP:
+		case IPPROTO_GRE:
 			new_timeout = NF_CT_DAY;
 			break;
 		case IPPROTO_TCP:
-- 
2.43.0

