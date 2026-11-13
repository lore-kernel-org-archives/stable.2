Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575085;
	b=Be6SVc/yiKsK8fyvWIQvwCbPLQzcTO4ecJRNKSebDEv9lV0JDxH2dpR6c7U3MMTTXkNL
	 aCmhzbMY8U5iO7ZpVbkxTi6dNODHKUZKnsB9WCrSsqCwzJtbgUtS/83oxT0uj6Jf7yn2z
	 CMda1lhKvH59tuH0IhH09wT4Ha0gvQgSIR4mZ7xAlDsZQYbv904lYx2L4uWCnrxbJJuDc
	 zwg63xvbDMVzVmf5tGD3Vvx+zGQLaarYZi7oa/9ktAQTCeBjy6QMlpeh9wGaqW12DA4RM
	 zDjLzfJAchHmmV68oggCD6W0mKFd/5lvklrkXHYMrn8Ve8KOEcDZXMrmDfU6j5pIXFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575085;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=iziSx9es7u8nolVrMECE7Klr8VpVpRBY3HGtY2UpGj0=;
	b=M+MZT+FaDZKrl5hHjC9A7P9qypjs9G8UdFHM2yZovsHuVaA7F3DcSuaq1XAU5m/YIFcB
	 i2P0D/g9uNQTQoGVLejU4yc8ClGTgdCh0WUbINGcZZInHL9nMveSYvynmxcaV8JvQwUG0
	 7wmN4FPNuCvfQSpmaNyoc1tJSAZGcXN/54t4gs7muDJE0uBSsvVAKy+XdZuWWaVSCnxL0
	 M9De3BRoOvgKUePy3ZLPiuy/dCni3Bm/PyOz2HpNyahhj6D/AFlWqDLFkmlOJRLa/eBH6
	 wWtkIPquiXI+YAK6dqN/md08KHOQdv/eK4JWak5G+nUzyuklzQtooTkLpAJ4sePTqog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cZ+0rblr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E1606A32E;
	Fri, 13 Nov 2026 13:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 110E1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=cZ+0rblr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=iziSx9es7u8nolVrMECE7Klr8VpVpRBY3HGtY2UpGj0=; b=cZ+0rblrdq/NjOA/s8n3/KyRyh
	DlK4bDrVMe6kRayl0MGo5S3szZOnWZwf4hP6IsznQ6wBCSCzGHHK3CBaT2X2TvtxGNqhp3Uw1wA6I
	mKVjvIrgcqey7ziRh1OeKc1FNFwusqQ7RIK8Qp0eB04ribkbBuwtqO/ZtcN12G20OgaybcRiDG7me
	iMvLBJyM6opIVkaKq5k314hgN04Jujx2uEIibc4LcFwhz482MSsZ5DAUdEKiP3yhNAEK5ACCVFtlA
	saGdMgoZddBcxDod+27JpqD5GwKZjqVpXjqkToG/QxFD5xQDi4EmMzJxFWqv0fN95LaDUr76vCL5y
	JJY43ncg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRqxG-00Elkz-2H;
	Fri, 13 Nov 2026 13:04:35 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 0/2] x86/mce: Rate-limit messages from corrected error
 floods
Date: Fri, 13 Nov 2026 04:49:13 -0800
Message-Id: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8H92oC/3XMTQqDMBBA4auEWZuSjBp/Vr1HKSUmow5ULYlIi
 3j3ootCC90++N4KkQJThFqsEGjhyNMItUgTAa63Y0eSPdQCUKFRJRZycHwLdqY7DzxLZbIMNaE
 vnYdEwCNQy8/jd7kmAnqO8xRex37Re/13WrTU0ros9W1hqiY1Z08N2/E0hQ721YIfrrXGX447r
 8gUKs9zNM0X37btDZx/M3fqAAAA
X-Change-ID: 20260827-mci_ratelimit-064421e2d8cd
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Qiuxu Zhuo <qzhuo@nvidia.com>, 
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rik van Riel <riel@surriel.com>, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=leitao@debian.org;
 h=from:subject:message-id; bh=94+KDlayX7uX9H0jidozRa4JYF+1X1Q/z33g5mwKxrQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9wrdZvKhKkrNBRRf9VGuxgIh2ZHGU9VcSyybU
 HT86BlSxUGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavcK3QAKCRA1o5Of/Hh3
 bXi9D/0VoAEuAjP18wzeFSgkB2jfrA+v1W/Ef2qY/68V9wWvTBeRtKpITak/iwuy00f3DsB7efV
 fDZkYrWsi8L8Q8TjRzJqtHlxneulMB8p+9bwnS0MYvXrAz++SXCFRalJ0Piqxhk1iUUF2QR16x2
 lJIjDVo2WNb5VB6z54oiqwx5badf3kXo7bsS/DiJOuirkW2F7ZHPqztGufUTNvFbPv5Tp2L+y6c
 ohdCRfrnUpHiJkhfkn8Avw3XX4aaIK8PNtKBv8B52t1PbyhhFZ2iJTH9kh53cE1uPWMP028tfII
 JGNH3WjUitdYYgoqwHWJ+8BhAmXow4GWwOhhnPu/bxCCQykC6cX03VQ5Hp7R/DoexHrv4sH9D3G
 S7evyIXk4QA/4tATZtiWjubjhSIhxPuzmT5SPdOy+kpEHLinRBQ+fTaj0FI0yHX70hT5PjG/cdU
 Vw92MsIxAaaqgL/om8heFdjNYj6/cViLS9HO5LUJEJ4S51eK9uJUSznB3W7ICJOaM31wcTwQMBa
 CE/6AdKiA7gH4dg6m6DiTZ0GA7p7B/5NTU+1FqCA9CD0WPzHLU1ikXqOpCm9TcUuP+mwSTUhDAU
 BHd9oztM36i7pzfkoK6yCS38aGpH34AdkDFv7hhaOPbtQg7IAwHNtvP4uuycc+4oRqqjnflSGHc
 jAfyNQejU5ThDug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A machine check bank that reports corrected errors at a high rate
makes the MCE code print two messages without any bound: "Machine
check events logged" for every error mce_log() queues, and "CMCI storm
detected" / "CMCI storm subsided" every time the bank enters or leaves
storm mode.

One host printed about 100 million "Machine check events logged" lines
an hour. On another, the storm notices were 82% of everything it wrote
to the kernel log.

Patch 1, from Rik, restores the two-per-minute limit that "Machine
check events logged" had before it moved into mce_log(). It is a fix
and is tagged for stable.

Patch 2 puts both storm notices behind one ratelimit, with the default
interval and burst.

Only the messages are limited. The errors are still logged and storm
handling is unchanged.

Both patches were posted separately before. Borislav asked to merge
them into one series [1].

[1] https://lore.kernel.org/r/20261112182125.GDavYDpdJpmpU2Piyu@fat_crate.local

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v3:
- Add Rik's "x86/mce: Restore rate limit on MCE logged message" as
  patch 1 (Borislav). It carries the Reviewed-by tags from its
  posting; only its first changelog sentence changed (typo, commit
  reference style).
- Link to Rik's posting: https://patch.msgid.link/20261108143751.3af49e48@fangorn
- Link to v2: https://patch.msgid.link/20261112-mci_ratelimit-v2-1-a9e67055526b@debian.org

Changes in v2:
- rebased on linux-next
- Link to v1: https://patch.msgid.link/20260827-mci_ratelimit-v1-1-ac43df769b36@debian.org

---
Breno Leitao (1):
      x86/mce: Rate-limit the CMCI storm transition notices

Rik van Riel (1):
      x86/mce: Restore rate limit on MCE logged message

 arch/x86/kernel/cpu/mce/core.c      |  6 +++++-
 arch/x86/kernel/cpu/mce/threshold.c | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20260827-mci_ratelimit-064421e2d8cd

Best regards,
--  
Breno Leitao <leitao@debian.org>

