Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA4369D50;
	Sat, 18 Jul 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401405; cv=none; b=STFqOHWqmCZlMOLoKbRDcID/LYh8q5PE4KoiIROJKtgrTTsEAZLswIU7GemGBZ3SzSmXXSQivf3PITkb2TILuIDWv+T/KtY4mW7JXiwJ+x9+031RIAADFRqxvCzDD/3lUhev6qSvnL9ytR9Y43nRBC23pb9ven2cWrstksFey58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401405; c=relaxed/simple;
	bh=zhYYvOhaho/7VgCq3WK6nUGsOlDKZXKgAJs8jB71zsw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Il9h/J25mgPDdZWxxx7q3PSSh+e+IJwZpQ3bkMsnmEzhpGIRkn4UI6lNqoqXOqutnFc7SsUG0RsPkV99hf+fmSSgWfUtLdbC+Ow4qVXm5221rFqY/v9AA+1YTMAWQJKKnlWVpjB711JlqDAkr3EJIyV6aam+flWNefugnnmQFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=LBLx6jl8; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="LBLx6jl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784401392; x=1784660592;
	bh=0mMT9SlGMTbWgB8nWj8kf5WAsWksPyAGRgxPmE3iLwg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LBLx6jl82226ppSRX0g51UqTpWojt0T2dfC5llecoYy2UBWGHI1v61wXtaNbQaBUr
	 3/zXUF7Bw3ERGaSqFmrZbN/jXXIigqdPsf+VLhTYzgpiqr25g7Doe1ltsvTC2pMSXg
	 aQAYDDKEmh0NKDMzOJ1KC5JP1+o4RKWqPcoXD4SiEsWhd7d39uwV64GhXgjs1YqIWk
	 pC8VkBj1OOMyEQCbrTVudBINaWZgep4lflxWGYLY0PX40bmxt2QWwlqIDkZxZgq5D0
	 lh9Iw2vbvEd7s58bAKl+XCc36UBhePx5kYolHAX4OVKO6G2VVR8ntaA/sTHWobBKgK
	 E3XQI8V5CY6sw==
Date: Sat, 18 Jul 2026 19:03:07 +0000
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
From: YANXIN LI <fadouse@pm.me>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, stable@vger.kernel.org
Subject: [PATCH] ufs: use u64 for directory size in ufs_last_byte
Message-ID: <20260718190300.867109-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: c098664789eca833834cd241e3972dfec92dd384
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------e5c151bfc3db30c68330db426ce0f9a46ad89cda13042ea907b012f059cd9061"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e5c151bfc3db30c68330db426ce0f9a46ad89cda13042ea907b012f059cd9061
Content-Type: multipart/mixed;
 boundary=0fafd488aa6eda8a14572b502f6c93bf8243223ced30784f759ab26816d2
From: YANXIN LI <fadouse@pm.me>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ufs: use u64 for directory size in ufs_last_byte
Date: Sun, 19 Jul 2026 03:03:00 +0800
Message-ID: <20260718190300.867109-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--0fafd488aa6eda8a14572b502f6c93bf8243223ced30784f759ab26816d2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ufs1_read_inode() and ufs2_read_inode() copy the untrusted 64-bit
on-disk size into inode->i_size.  ufs_last_byte() then truncates that
value to an unsigned int before calculating the valid extent of a
directory folio.

A directory size of exactly 4 GiB is truncated to zero.  In
ufs_find_entry(), subtracting the requested record length from that zero
forms an endpoint almost 4 GiB beyond the mapped folio.  A crafted UFS2
image produces:

  BUG: KASAN: use-after-free in ufs_find_entry+0x583/0x6e0 [ufs]
  Read of size 1
  ...
  ufs_find_entry
  ufs_inode_by_name
  ufs_lookup
  __lookup_slow
  path_lookupat

The KASAN classification reflects that the adjacent physical page was
free; the source-level operation is an out-of-folio read.  A controlled
UFS1 test with CONFIG_UFS_FS_WRITE enabled also made ufs_find_entry()
return a directory entry from an adjacent anonymous page.  unlink() then
passed that pointer to ufs_delete_entry(), which cleared the adjacent
page's 3
2-bit d_ino.  This write result reproduced three out of three
times.

UFS normally requires a privileged mount path.  A relevant boundary is
a privileged automounter or image-processing service handling an
attacker-supplied filesystem.  The write primitive additionally requires
UFS1 to be mounted read-write with CONFIG_UFS_FS_WRITE enabled; the read
is reachable with read-only UFS2.

Keep the intermediate size arithmetic at 64 bits so non-final pages are
bounded at PAGE_SIZE.  With this change, the same controlled tests reach
the real on-disk directory entry and produce no adjacent-page write or
KASAN report.  A reproducer and full validation logs are available on
request.

The vulnerable helper is present in v7.2-rc3, v7.1, v6.18.38, v6.12.95,
v6.6.111, and upstream master at 1229e2e57a5c.  Runtime reproduction and
fix validation were performed in an x86-64 QEMU guest running v7.2-rc3
with generic KASAN.

Fixes: b71034e5e67d ("[PATCH] ufs: directory and page cache:
 from blocks to pages")
Cc: stable@vger.kernel.org
Signed-off-by: YANXIN LI <fadouse@pm.me>
---
 fs/ufs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index e62fe5667..69e6d5535 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -213,7 +213,7 @@ static void *ufs_get_folio(struct inode *dir, unsigned long n,
 static unsigned
 ufs_last_byte(struct inode *inode, unsigned long page_nr)
 {
-	unsigned last_byte = inode->i_size;
+	u64 last_byte = inode->i_size;
 
 	last_byte -= page_nr << PAGE_SHIFT;
 	if (last_byte > PAGE_SIZE)

base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
-- 
2.54.0


--0fafd488aa6eda8a14572b502f6c93bf8243223ced30784f759ab26816d2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYVV1T01SWUpLd1lCQkFIYVJ3
OEJBUWRBdG5ZbFN6SFRMSEEySXp1TkUxQXk4SnJLVUN4NmhQKy90YzRMCkRYQ25yZXpOSFdaaFpH
OTFjMlZBY0cwdWJXVWdQR1poWkc5MWMyVkFjRzB1YldVK3dzQVJCQk1XQ2dDREJZSnAKUzQ0eEF3
c0pCd2tRdVoxZ3QrWG0yWFJGRkFBQUFBQUFIQUFnYzJGc2RFQnViM1JoZEdsdmJuTXViM0JsYm5C
bgpjR3B6TG05eVp6bTBCcDNlRVhSV2tuSWdDbFd3dmR4Wm1vMVhuVmI2RmthalhUVk0xQi9qQXhV
S0NBUVdBQUlCCkFoa0JBcHNEQWg0QkZpRUVtVWhhbzNaL0FuQkk0TEJZdVoxZ3QrWG0yWFFBQUxx
MkFRRDc4SzZwZWRTWDNsZE4KeXFkM09IMXVNak8zdjdMWU1oTytsN2NuU0xXckVBRCtPQ1NxMTFT
ZWFLb2JzVkdyTGVqVE1zbU1zUEI4am54ZgppZDNoQ04rcGV3VE9PQVJwUzQ0eEVnb3JCZ0VFQVpk
VkFRVUJBUWRBd1hkelZJcUVIL3g4SFpqUi9QT3QyQWlGCmJFbTZZcVhYMmoydjJpS0RzUU1EQVFn
SHdyNEVHQllLQUhBRmdtbExqakVKRUxtZFlMZmw1dGwwUlJRQUFBQUEKQUJ3QUlITmhiSFJBYm05
MFlYUnBiMjV6TG05d1pXNXdaM0JxY3k1dmNtZGRLTlFZREZXY0VWZDN4T0hlUXA2cwp5bjc5TkZw
TnFrSHoraXpwSUxCblVnS2JEQlloQkpsSVdxTjJmd0p3U09Dd1dMbWRZTGZsNXRsMEFBRHpRZ0Qv
CmNJSjA4OUprbm9nVHM2dnZRWitKM0xSSURhSTkrUW0rVDVxT21OazR5WEVCQUxQSWxKQ1M4YWg1
ZEJZWmE5TCsKSHFqYkRtZVNnRG81OHVTeCtpV3crNlVMCj1NdXNUCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0=
--0fafd488aa6eda8a14572b502f6c93bf8243223ced30784f759ab26816d2--

--------e5c151bfc3db30c68330db426ce0f9a46ad89cda13042ea907b012f059cd9061
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmpbzekJELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmex002270kdeI29v4hUlShPFiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAAK/DAP9K7aa07ZVJFLrZa/xic+EAGWzsYQli8Y7eih0+
qA29pwEAw/2jiAm3nvdLkkJUhf6mZQDxfb8mN6JZUrZis/7Qkws=
=WP5q
-----END PGP SIGNATURE-----


--------e5c151bfc3db30c68330db426ce0f9a46ad89cda13042ea907b012f059cd9061--

