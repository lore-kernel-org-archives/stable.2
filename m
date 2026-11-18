Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984893;
	b=CvGjTRPLBaR7EpKCQfTWrIwjieLtpi0VSAsvsHezNHBrMcyJzC8WNUXImn/m0A3xeaxj
	 yCvH4+HYvJOkA70RRWSbSH8eYXgMYnFGNDtKRlCGvPVIH0imsbXVOc4yW8tjg3mdtFQLi
	 257bPbmKEwPEO36+Iwp2roY5xH10bSSyt4uk080J0saXSNfDJ1MXSJ9jNGyQ6Or1Qj5wz
	 40VdjTlRAKjB3eIcbeVUDhf0jRbg+79HmciGW8WQPGvlGabc5kMBXRSpcgjWz3Rgh5I09
	 Qfw7QvAKi+qTB7e9GTtS5kqvK+H66YpqujgUWQb/0IMs0dBgn1xuSNxWWuLRFr2jUkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uGKNbASRAWUDD5bnx4///wXi8po0trOwy1MwYu/ebyE=;
	b=GdYIysmxTLgIkg9JAHLR5Rzc5A3FIfvE/Rp2tbh0A8tgCe/xhtltpQXlqtr0hqRECxmm
	 ehk2m9BlSqDq7G19CXxP3QesVQZf6oDmdHk/yhdzrWGYpgm6PrSl/D5FKNCkwpy2Q4tq2
	 5ibTqAIhBKwUkAtdwHh9+bpsCOT6zqt/AXRvk/8N5IPl8wOep3lSzYVHqgb6rYaOvdr05
	 SssdbsN6TGSry0L4ct6V/K80ieQLPNvotQL2s305NJTbUpgCq2/iKHh/4KqKK+d7egIUT
	 5cvlZtyCkKm+oS7NAV/fqtHZJVozq5lfVAmiZBsOZpUjYtQPEtdCqXkpKqYxHIN0ZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmZq2ZeB;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33362606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33362606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OmZq2ZeB
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3704d30b84fso975840eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 22:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794984892; x=1795589692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uGKNbASRAWUDD5bnx4///wXi8po0trOwy1MwYu/ebyE=;
        b=OmZq2ZeBnbmnVbudVzZGINOF5SILPyruawWQPcnS96edtp02iVD2NwkHASrWlJQNUA
         3EKwqDPvBedBz5nM/mDTJgLkbaMItHZIN5fokXNtUKQTc1dHtI3AUKXW7/HBV4qatlNB
         BUVwW7JaOZ/jr5PcWsaAG2Pc0qy88QVoIfDzJylwn7AcS4mT+P+xBdC1KDnSekAP1fsb
         cuUJ3sEgPZ9t2DydWNF78U9g8ntxEEajgEly57XD7DsrFRV8T2c30Fr5eMpAoRIazLcF
         Owl611jo6i2mYzV961Mgr4GBH0NdlrdVpz7rKre7SvFyitN/otPaKWF2/xyE6G9g/KCi
         by2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984892; x=1795589692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGKNbASRAWUDD5bnx4///wXi8po0trOwy1MwYu/ebyE=;
        b=ygds+vGUGl3twNoC0D1mGAEhIkoYT5+N28eYdS/9cuCAO9zwYzUORplnaN7Mo0fXrb
         WboCcmWQ6PvwsnI9hn6ua5mE6J7L511mPHtevCM2Be4FWM2v0MYJ0bC5GmSgb2Y3cxRd
         4WOb+b9M2Zrrj08ylzl6l7tRKdeejDrsxpAmYCOcC7is96sjSwJ0tg8DoKYkAU1anOU9
         DTWNOS3V49AQqTvEbHsOs6IYF4Ant1DCni3EoNJ4WdK7pf/5ZLzlvxZXfruAsjKEThH4
         fR8WH/vd9sU3Aeefo5KB5ODsoQgPMKT+SZnGH6NvFoiVoe149wKNxkrEUJg32Swub7tS
         Xq8w==
X-Forwarded-Encrypted: i=1; AL+hErGPIFDuubKnLqpC9z57M17Hms3/e0Uia9bto+FKcmMDda7hVI0nkwyM8lDdxpI5nEsWILXkCbY=@vger.kernel.org
X-Gm-Message-State: APuU4Z80ss8ll+ItHu5sYN3QxFutewHxK72wsYvLy7DIIXKcWQ1mtOwl
	LyEEN9V6qJJxE7Rf9gD0Inopo4PuoYjGylmn4QslUitIe2iu1hP+5BgB
X-Gm-Gg: AYBFou3CPSwNEnvzhxc0DD7MvEry0vpfBxuGF/+3yYIq0quughwk6rUj2QfURwjZy/0
	ayBDTRMdiFfOe5NIg43EZtoh1esxRu6VtGS8/cMQSdDP30utx/wWSGwGpQ9UUDP5EO9/rFKoFKp
	+N9LUAMdYGagfEm+W4zsEjPkJbXohsJIRBJvo+85TV5xPBR4/B4YuQQ48OkSxV/PmLHXgb8hspG
	5WO4vEPTgOq6euu/lK6tFpK/GyI3AaXIakBsQiejWcJSxW6TntzYjaAmCu/eRWA7wZlHhoF4FD0
	G7D5Xdk6Bgwnhc0Wq7BZUA+cacRp+AZ14vO9fzJgZeVUkpKeuL8BrGht5/3L+Lh8U/gWcon60id
	JSgsXRVuw8oTo3T88TPdm2YIOo8+qPMIvPxcBOZuhaBC9LAuFJuT+A1f9OvYmkguQ02YJJKqk+O
	flJaSJ58uHwJAvtE1zIzH4ZcD761k+LrDoLnLtS4Sdoj7swFg9szKl03TDaFLmR//wDS27qDjaS
	Mv9bei5x8jo2Qnq1RkZYhYCGpTD0XgNkmtL+UcGA+hQlwhrfKIvifrT28hD5g/ZUJOpUUPcJ18U
	yVrTHeUXI/vCeXIi1Xp9ouMH
X-Received: by 2002:a05:7301:f0b:b0:368:7c2d:a612 with SMTP id 5a478bee46e88-3828007a784mr1564917eec.10.1794984892012;
        Tue, 17 Nov 2026 22:54:52 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm4612640eec.28.2026.11.17.22.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:54:51 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net v5 0/2] net: openvswitch: fix a feature leak on a failed change
Date: Wed, 18 Nov 2026 01:54:33 -0500
Message-ID: <20261118065435.2367014-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.1
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

ovs_dp_change() records the requested user features before it calls the
update that can fail, so a request rejected for an empty per-cpu-pids
leaves the datapath claiming a feature it never enabled. The tc skb
extension key is a reference count shared with cls_flower, and the code
that would keep it in step is skipped on that path.

Patch 1 fixes the ordering, and drops the reference on the two other
paths that take one and never give it back. Patch 2 adds a set-dp
command to the openvswitch selftest tool, and two tests that send such a
request and check the features the datapath reports afterwards. They
fail without the fix and pass with it.

The problem turned up while the YNL spec for this family was being
written: describing the ovs_datapath set command meant reading
ovs_dp_change(), where the ordering stands out.

v5:
 - Rebased onto current net.
 - The two teardown paths clear only OVS_DP_F_TC_RECIRC_SHARING, so a
   datapath on its way out keeps the bits an upcall in flight still reads.
   A whole-field store clears OVS_DP_F_UNALIGNED between the two reads in
   queue_userspace_packet() and pad_packet() (reported by Sashiko).
 - queue_userspace_packet() reads the features once and gives that value
   to pad_packet(), so OVS_DP_CMD_SET cannot split the head room decision
   from the padding decision either.
 - The tests write their diagnostics to stderr, the skip message
   included. A copy of stdout stayed open in the daemons the suite
   starts, which kept the kselftest runner reading a pipe that never
   reached EOF, so the run hung after the last subtest (reported by
   Matthieu Baerts).
 - A datapath that cannot be read, and one that reports no features, are
   told apart and reported as such instead of as a feature mismatch, and
   a failed expectation carries its own description.
 - checkpatch reports nothing for either patch.

v4: https://lore.kernel.org/netdev/20261115163134.3202677-1-houminxi@gmail.com/
 - Rebased onto current main, the tests say why they failed, and a
   datapath that cannot be read is no longer reported as a feature
   mismatch.

v3: https://lore.kernel.org/netdev/20261110174651.972936-1-houminxi@gmail.com/
 - Cover the recirc bit as well as the dispatch bit.

v2: https://lore.kernel.org/netdev/20261108123424.2825403-1-houminxi@gmail.com/
 - Name the two paths that leaked a reference and fix both.

v1: https://lore.kernel.org/netdev/20261107113403.797779-1-houminxi@gmail.com/

Neither leak has a test of its own. The reference count behind the bit is
not visible from user space, so the tests read back the features a
datapath reports: the reset drops them to zero where a test can see it,
and a datapath freed after a failed creation leaves no state to check.
The alignment race has no test either, because it needs a set or a
destroy to land between two reads of the field on another CPU, which a
functional test cannot schedule; the patch removes the second read
instead.

One thing this series leaves alone: ovs_add_dp() returns the status of the
last command in its body rather than of the add, so the "|| return 1" that
follows its calls cannot fail. That predates this series and every OVS
test that uses it.

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
  net: openvswitch: do not record user features when the change fails
  selftests/net/openvswitch: check that a failed set keeps the features

 net/openvswitch/datapath.c                    |  58 ++++--
 net/openvswitch/datapath.h                    |   7 +-
 .../testing/selftests/net/openvswitch/config  |   3 +
 .../selftests/net/openvswitch/openvswitch.sh  | 195 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |  65 ++++++
 5 files changed, 310 insertions(+), 18 deletions(-)


base-commit: 2a324a58a084c5cfd7e5a2f55e0786bee170a4a5
-- 
2.56.1

