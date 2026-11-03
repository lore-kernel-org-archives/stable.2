Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706638;
	b=DBQfh4HPloqflUuXryXbSXLylE7uHB71Q4ypGOd1soB9E4In8Hb251xE16E1/Su64fmH
	 OYMZ9J9BbbPLJn0Z1cCmfbmsPI0J/tlDgvX56c24P9nmlGt40bqeuNdZkcYgb48GLDsVJ
	 aIHSVA/oM2KM+ZRsPQU/3rP9txK8jItmDFk0EP4P2xCzaDd1jPJRfp5gh6rgWz9qQL4fX
	 EVTJqNBLVI/+/oIgyjLSTbNcbmMNta1E/o5VuDf8C2JDgzIaxxqPhO4vT8Eg3XZ7s+PIB
	 Pzw8imV5NukH5av42CNh9HOAf2Hno4nC1cgHyCHhiZ8y/sA5zA/rXtEBzSBTXxlUy0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
	b=CyMtKBkiyzFnyFEktrkpH9FkWbN0odb6yieAfT6GGgr94zS0saNVl+yO8Ty79ovuwhlD
	 CFgtGdeBn9xtVIr4BfDnhkfDjzkmwDScdkFg1gxRyuLS6TEAHzAwaf+yLDMG0nsi8EXlK
	 +M7qkj7Ii2q3anGyQKpawwK5bMYkzIm/UZfHGQWW2CBuHVXvbG6hAIEi/3ZQ1//7For2H
	 8nNfHWCwcFrxBruFfwsqvmirEC/mtW6cX7kGPMa1wyyz/ued03cS3LmGzud9eiyss1LvR
	 s6++xocA3W+14aw3RkWoIv8psBm6rWFqtl4TZTeSWhVl1h0Veh5XVFfnBe9BwF+cv5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SM83Qf9N;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD649606EEB0
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD649606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SM83Qf9N
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679965fb848so4170529d50.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706637; x=1794311437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
        b=SM83Qf9NT+SVsUiUy+tTcJBP+bhj27xdLr5TwKW9X3AhPEMUBFKimxyNr36cGB9ybP
         PWWD7bW/bpvEE6UX2ABkt5nox7TMUIHabOtmOqNpki/3A231PcqnuD7DiSnq3wHohoiR
         SnQ+C12ADuw0H7Vo/DhbHdpyPmlSW2yLlyiCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706637; x=1794311437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
        b=fa1QKlikkB91afc4BnkZPNaM2CYLRFLG6IDokGf/GnDZ4L6zKrkL4h+EVRRbv1oQpC
         wN0XCbfwUEuTUNdX8/dfPS+fpV/ibY8BhMXSMWBEVPpHiMD8OEFLMbrv8rjtxB2kgpi3
         tsmdhGuuwrkv+HJeNOtbHinanDgpw/TbSY4XoGLVrCWai/JUft9gpZwH4QTeRRHqA2iB
         T1WJ+70jyhPuMxXw4jjcOOXxp4KywKJR/AGSm30n3+4bp9bphwqfBAKk4KzzP0T+w9dc
         BGBuspD2pqfYRBcAsfdT50lJHBQFuChyixHNGgBvnC6S9Uje5zu2T/xYyEONgKAXwTqt
         0YPA==
X-Forwarded-Encrypted: i=1; AKwUvBz2j0/CBQphnOjKqyZGR15QoyGyLvc+lebjPvPwLiV92yVmyGv+2Ogx2SDWk3HHVmRNxx/yE5Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JIYyT4GynWeiLVM/MpCFoVPUe3PxuwPmwwofNGa67A/NIWDd+
	rxl+bwPXkpjA2c0rk2h8BZfz32hjn/JhRuWprX3GRDFL52GSjFbph58YjAPX1Vm2bg==
X-Gm-Gg: AYBFou3ExihcrtnQwTxeccKHhQD5qBWw0XI1zJRiscmAkeUFnS0csHakCT7VyKGgKM2
	qGephBKhvREfFs4KpuhQVt9qMwahpG7bzW/aY6TR+2ETVUaDjiyV8VtcZ/7gbDwsFTPqmB0vFKa
	mS6mgB0i3TKwryaYsAczinBFrV94K6UeABgn5IQU3FyS13VnuIzUNPRp4z5xtz+gmRJra2NYgxE
	wBO8Nw7Au3TnV0JEB0QCOyl7amdsNUJFwVHwgzuDfjN7Hpt0yPz6RstQve4E3mywJp/OU5C/Oqp
	+AtxlzKpopqWlLpHxCdIOlM6wT2SBrlO2blF1yW5Cm8Onn7sxippT85h5NA4IlVq6ALgFhr5JiW
	oVhCNBAXLJA7PMYxNsx+fgFEh79odRjMobUQfNukGtxi0Nbh4yvmPSOIfLB05qectbQeDQRDA/c
	uReBNzG7L0W3ZElFe55ul5r2F41lAcwkq5AcZPONah1qb/y5O/GHnIsXfkqonCaoBMA6GVmFtlp
	lqywNlxYi2qgQ5nFRxjzZ2QzJgCVplJon3sKOLdAUEPtH68/JBkCUsAQE6UDjL94Ar7gggQxtx+
	VNtpVJUa3SGiDvBiF/+twZDZYqojW4nD/h+I07qHguZFuVAuMADxk9Pd7zb65eJixbOwDAuM5h3
	HWbl7Vv0PzHT+fh0=
X-Received: by 2002:a05:690c:fce:b0:8b1:738a:b44c with SMTP id 00721157ae682-8b2b66c780bmr74176927b3.23.1793706636793;
        Tue, 03 Nov 2026 03:50:36 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:36 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Tom Goff <thomas.goff@boeing.com>,
	Shuah Khan <shuah@kernel.org>,
	Yotam Gigi <yotam.gi@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/4] net/sched: fix short-skb metadata and namespace boundaries
Date: Tue,  3 Nov 2026 06:50:28 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes three independent boundary problems in net/sched, and
covers the third one with tc-testing cases.

1/4 act_ife: encode a configured zero metadata value.  The u32 and u16
presence callbacks reserve an 8-byte TLV for a configured zero value, but
the encoders returned without writing it, leaking stale skb headroom bytes.

2/4 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/4 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

4/4 selftests: tc-testing: cover each of the two teql attach rejections on
its own.  Case 124e moves to the initial namespace, where it creates its
own device, so only the root-only check can refuse it; a root attach from
the test namespace is refused only by the namespace check.

Origins:

1/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/4: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
4/4: follows Sashiko (nipa) reviews of the v2 posting, which pointed out
that a single case cannot witness both teql attach rejections.

The four patches are independent.  They target net and the three fixes
carry a stable nomination; the test cases do not.  They are sent together
because they share the short-skb and namespace-boundary review context.

Jamal Hadi Salim (4):
  net/sched: act_ife: encode configured zero metadata values
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace
  selftests: tc-testing: teql: cover each attach rejection on its own

 net/sched/act_ife.c                                | 13 ++++----
 net/sched/sch_teql.c                               |  9 ++++--
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json | 36 ++++++++++++++++++----
 3 files changed, 44 insertions(+), 14 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2 -> v3: considers comments from Sashiko (nipa) on the v2 posting.  Case 124e
ran under nsPlugin, in a namespace where the teql0 master is not present,
so the namespace check answered it and the case no longer proved that a
child attach is refused as such; the case added in v2 covered only the
namespace check.  124e now runs in the initial namespace and creates its
own device, and the namespace rejection keeps its own case.  Both cases
were verified to fail when the check they exercise is removed.

1/4's and 3/4's diffs are unchanged from the v2 posting, so neither carries
a changelog; 2/4's Fixes: tag now names the commit that introduced the
unguarded copy.

v1 -> v2: considers comments from Sashiko (nipa) on the repost2 posting.  The
cross-netns check in 3/4 ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent validation
now runs first and the namespace check second, and 4/4 covers the namespace
rejection on its own as suggested by sashiko-nipa.

1/4 and 2/4 are unchanged from the repost2 posting.
