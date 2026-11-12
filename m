Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487566;
	b=Z+uqtWeQEmJm2aKkEohqcpyhV7+GxFMve9hDFNOZ8GO5S+X0b6K9b+BZdXVCKMZ00Y++
	 Dd4K7J1xeLzdjRuLSg+46DTbknTj1HdP+6Edxx3c2ASkh5unkwZXhQ8gHnShiJ15fFZVp
	 qu+S6SlGLStGgyPNYnG2ifnaPNtZ0IhkY5EbP9XaVhV0fteb2D5A/C/hkZHp60n3eBAZ2
	 W5OAmcGL6woEs9dROUh90jtbjWJpUl2LeoDsrXSxnh2JkQw/8pRNQVYAH7c2pRhrg6KeE
	 7nViHTcw4Pw9rc+e9XvgHIhMUkik8olDvHWqVhMr7mdVUZU+NJNAmf2DXLMPD+rgdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487566;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vc0NrXd+yFpV3sold/b+8tm1+Fzn8ECdrNUXiAkQ2d0=;
	b=aycaPYdrDtEIlrk0dDO4mqx66O8G9VFKZFfHh/VUy4/p37V26If3S+/FnqTihOsU7Ljc
	 lf/UtwsAWndkNuHNq0Yf8jUwnk2eIGhfGD5k/86UHaEl32gJyMJMR4fJ0PRFtqSaM8kDI
	 xn7PbXmtNLUa2w58NIH3kI8PsJMKHkyGz3ccnrUB1FY4iQuUaoUSh37ZjiBc5EMG1TL64
	 WqR5erXc1KxnExocVpa7A7kmBEgMwFP0o4SgsKX6G22Q1kb7w6BB/hzeDRjVN6htLj0Wh
	 teXXTwGvUdPAaYdmzkJkY1VzIDOGDcH1X37N+Mz64J3gCb8nFe7mYEURnob0YnXRAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OPhGp7M9;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A13606A89D;
	Thu, 12 Nov 2026 12:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A13606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OPhGp7M9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794487557; bh=vc0NrXd+yFpV3sold/b+8tm1+Fzn8ECdrNUXiAkQ2d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPhGp7M9uiCvTshMlQkcrMfECSUJdfsXAAdJLg2qM4EpFUWr7laC7i0ui4nWoCouN
	 Kk5eJX1Lx9mHUfAcQSSuPgHmfXy9lMU4nvyajEkWZR0htglH7GqbfmPudA3AhbGrZ9
	 aZ5eSiTaMIHBY4fdgP2m8UzSXcRaFD2NMjTkTMdE=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:e498:8f16:a485:ceef])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B70218AE; Thu, 12 Nov 2026 20:45:48 +0800
X-QQ-mid: xmsmtpt1794487553tnhmcb0sk
Message-ID: <tencent_AE3D481F5F51E98E657317C2F664C4FA4F08@qq.com>
X-QQ-XMAILINFO: OAope3s6+8XpCRb78Uo2DvztjnNPFEtCHZtGrY0EL6PxRo93AOYTMCSxQACTed
	 fX0hU+XaAk0md+Otrg0C+FgxzPx0l5Wpbzt6jbyoOHkmnqN4NG6stQaMBa5G6AhIcQR2tVUoQoxn
	 XUwvRasY7A1X7S3tKtBehV/uYMZSOjdOLCGi51eBAVb5YJ1nmwDjJzy7M5Dw+XKH+RzPXxC4c8NV
	 LrKJNdCWmgZLjM2eE9SvhPaRHphr9imJCL14drzTSXvbcTWEui/UuIGGZvYVbVqrw/RNQO/5Yxg1
	 zv0r+7kHQaxQFuxdYED1kNvmhfSfr8yne+3vM2czhWB2JyDN7QtPliPihzklJ0Hb7GcmEuL6/2/x
	 JkB+1IiJOlY52XdMza0pyo9fYi6aqA41v5ll8nqVLplOpxtiotb815jTDNhjDcSKI8Ap4S6ZUgvq
	 hlms+kDomE06zKxoXX8VlyIOMKh6hn+y2LbE5UIIQppywiVOLwWFyfHHZ/oRJ10Q0FYaP8u2RM8s
	 uXOqOcYPoYAb5UTtGj0q+HK4fTQxdxSRI0rwJcSSQ4sl1pdm2kZv/iTmKoltQmnq6N2BBMEEgVU2
	 MNuVKZDL2uXafliMNwpI8xx6vEzf6r6l7z+/e7fXyVXG0fEMBVE1Pdlf78lfE2y6RKBoW0g0fqVa
	 DNhDAkDtf339qNnZHDcy9FZCHOBUUE3hg27mEfC8uG3vzOwbBKf3aZHdXLPAxrV5OBihxIn0oMwX
	 2jMNp+yWHejiYR8wPuzhLOcX8Hq+ECzfACacX33D05Hr/u9LFIxat2Cq8HQlQyuInBeYZex1lDXk
	 zQK9kwAutr31qAn1WiqRjygtg+uPpYDWFFxqE9N7/nZnUEyMEDiZllerRI/+rp81f8pvmwcK1wrs
	 pvSnmgC6wUUn9/V0k2hHYd6C+hY4aISX5ooqLtzZmJBuuT37QzM4sHi2SCPkM9M/AGB/j2Z2sE7+
	 /eDsq7/9nFM/gsY6X5mRA1FHZRDDEkjy+BNLuMFbJtf+IcCy8TojH3+E9oOcHjKJY1AeIZkgbFbZ
	 LvESrgaKRTvbpfaaghM9Kcbx5UFA644Er7jAOQxTJbZTGf+AXY4CmV1PBlI1iQzWUm3ZTkrKuiaz
	 DQtB0csTDGY9TP6hOo4pKik4xLN+NSPj3tO+ZrXrg+BQxA80g=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	Hang Nan <2122295973@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: core: take the reuseport migration reference with acquire ordering
Date: Thu, 12 Nov 2026 20:45:47 +0800
X-OQ-MSGID: <20261112124547.193812-3-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112124547.193812-1-2122295973@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
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

reuseport_migrate_sock() returns a listener with a reference held, and
every caller immediately reads that listener: tcp_v4_rcv() and
tcp_v6_rcv() pass it to tcp_filter() and tcp_check_req(), and the
request-socket paths clone its state.  A listener removed from the
reuseport group concurrently with that lookup must not be observed in a
half-torn-down state after the reference was successfully taken.

refcount_inc_not_zero() lost its acquire ordering in the refcount_t
consolidation (fb041bb7c0a9), so these subsequent reads are not ordered
against the reference acquisition.  Use
refcount_inc_not_zero_acquire(), as was done for the established-socket
lookups, inet_twsk_purge() and bpf_sk_assign() in 5b5d8f351dd9.

No behaviour change on strongly ordered architectures.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/core/sock_reuseport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index fccbdd0430b0..78d1d7103122 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -666,7 +666,8 @@ struct sock *reuseport_migrate_sock(struct sock *sk,
 	if (!nsk)
 		nsk = reuseport_select_sock_by_hash(reuse, hash, socks);
 
-	if (IS_ERR_OR_NULL(nsk) || unlikely(!refcount_inc_not_zero(&nsk->sk_refcnt))) {
+	if (IS_ERR_OR_NULL(nsk) ||
+	    unlikely(!refcount_inc_not_zero_acquire(&nsk->sk_refcnt))) {
 		nsk = NULL;
 		goto failure;
 	}
-- 
2.53.0

