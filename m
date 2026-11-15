Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717470;
	b=PkHHULXTFNr3Zx5QTp3sR2xdGowEufjrrh8Bpu9xQ66fIs3WNV1TnMYS02eoulTni7ic
	 u86iRLVHfVWyWQPWinUKA/oytAUts8wXMwkSJndgDsESpJhh95xWlTGr2wTbm0mXpnlkI
	 I2S4WnSC1RAX7Kx6+cWtaEJeZAYa27C7eU+yUlbvLOQzp0JAVvjWKvfp5fIBM3nu3D+ZF
	 NtTNaJ4wn7Zjf/odLTW9uXQjF1SFxRxiILaXroGS20XZ10g3dYVyBzWWEWgUuDKLIVNVI
	 +VSRNruhqL7w3L2OrMj3gNbAIGcxrxuH3e1toT6rIOKxSL9EAxukPxf6JVUBpSDQgbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717470;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fiox8npA7vcktuSSypBhupUyZJNfQ8Xi0cqno2AYL58=;
	b=I5mHdoX60wYzvT06sEXiGByZJKjsOTpaUVQiCJ6pRwRetISCZyZnv8Fky0WJ3uWzY0I4
	 6RmF49FpV04afUEhB4GO4xOZGCOSPvDQhCCeUUvvcFxt40+LmmzoiCFEdt+O8cUybJ/WA
	 07jF3p7aBss4KSEOcEwFfr0bzQDaIGj/9Udkr8fEQ6h3Hj9OOAJMXe8nFnK8alOxh5L47
	 soP+6inmuZIqFEuXq0QjSq0uUEsxJSo5mrj/pUaOVhXV2geUhBwM1K/l1vr0kAjQ2Kwh5
	 2C5Frl+iN8B40IEdZ+oQd4CJBXHoBkJ8mcWf8Wr1x8u0bWswIxt3G7It6gIP4YeO2dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hrs/r8NJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A35606A323;
	Sun, 15 Nov 2026 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hrs/r8NJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7868C1F000C4;
	Sun, 15 Nov 2026 04:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717470;
	bh=fiox8npA7vcktuSSypBhupUyZJNfQ8Xi0cqno2AYL58=;
	h=From:Date:Subject:To:Cc;
	b=Hrs/r8NJFwoQ31ab4s7sZv+pqxnpMxh4nFdHw8s2cv6H0sslXfyHnVJ4uYNmQEisd
	 x3b3zurpRoAq9TihalbtF4GrBavCuZGoeh6+ZNslJDo4JZwSWJ3S/yx9+AV+M1xxPw
	 cIazmwjAgZyhlwE7XhgFfWXxTCthgJBbshFZqxhhyIULV+ueV4kiqrXaZXEj3vpGA9
	 8WEc8ZLk8+yj1rccmhum0XPQ8agJELuFWA21hrrngfJttVlkEbEL8CCQevzVpv4Zs3
	 DjV+rHl5vr7Wd6UrqqPks401jwmRhnvLexrhatVht3STcerH49u0qhikHtNzYQJdrZ
	 F2LvsN4F6uXPQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:37:31 -0700
Subject: [PATCH] lkdtm/usercopy: Avoid unsequenced accesses to cache_size
 in lkdtm_usercopy_init()
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
Message-Id: <20261114-lkdtm-usercopy-wunsequenced-v1-1-d9f288701932@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMSw7CMAxF0a1UHmMpqSBCbAUxAOcVzCctccNHV
 fdOgOEZ3DuRISuMNs1EGQ817VOFXzQkp306gjVWU+va4L1f8vUSxxuXmkk/vPlZkuFekASRAcg
 6oAsr56gehoxOX7/7dve3lcMZMn6XNM8f4yH1Mn8AAAA=
X-Change-ID: 20261114-lkdtm-usercopy-wunsequenced-eeec86ef6500
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4887; i=nathan@kernel.org;
 h=from:subject:message-id; bh=4midEWMf9NZGRC+22ADVD7A69KC1zsvLaU5UjWnFBUc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/zXlSZgV47++Uz1r2yu9kmvEyNikv3/h1p9qsciU3H
 rjImzalo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwk+gHD/wzPpluNhZeWWWkf
 Lr747fTja3/K7pxod4i5flbytsDLCTsYGR5bZXOvOhUtV6Je/OXuV8uUzaWbJdt0J2RvsXhc2fl
 MmgMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in lkdtm_usercopy_init(),
which can break the build with CONFIG_WERROR=y / W=e:

drivers/misc/lkdtm/usercopy.c:431:9: error: unsequenced accesses to volatile qualified 'cache_size' [-Werror,-Wunsequenced]
  429 |                 kmem_cache_create_usercopy("lkdtm-usercopy", cache_size,
      |                                                              ~~~~~~~~~~
  430 |                                            0, 0,
  431 |                                            cache_size / 4,
      |                                            ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior.  Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

cache_size is marked as volatile to hide its value from the compile time
constant checks in the hardened usercopy routines. Refactor the
calculations based on cache_size into their own volatile variables to
keep the values hidden while avoiding unsequenced accesses on the same
object.

Cc: stable@vger.kernel.org
Fixes: e47e311843de ("lkdtm: Update usercopy tests for whitelisting")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2195
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/misc/lkdtm/usercopy.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 67db57249a34..6c561dc1bcaa 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -19,10 +19,15 @@
  * hardened usercopy checks by added "unconst" to all the const copies,
  * and making sure "cache_size" isn't optimized into a const.
  */
+#define CACHE_SIZE 1024
 static volatile size_t unconst;
-static volatile size_t cache_size = 1024;
+static volatile size_t cache_size = CACHE_SIZE;
 static struct kmem_cache *whitelist_cache;
 
+/* Whitelisted window in buffer, from kmem_cache_create_usercopy. */
+static volatile size_t cache_whitelist_offset = CACHE_SIZE / 4;
+static volatile size_t cache_whitelist_size = CACHE_SIZE / 16;
+
 static const unsigned char test_text[] = "This is a test.\n";
 
 /*
@@ -204,7 +209,6 @@ static void do_usercopy_slab_whitelist(bool to_user)
 	unsigned long user_alloc;
 	unsigned char *buf = NULL;
 	unsigned char __user *user_addr;
-	size_t offset, size;
 
 	/* Make sure cache was prepared. */
 	if (!whitelist_cache) {
@@ -233,31 +237,31 @@ static void do_usercopy_slab_whitelist(bool to_user)
 
 	memset(buf, 'B', cache_size);
 
-	/* Whitelisted window in buffer, from kmem_cache_create_usercopy. */
-	offset = (cache_size / 4) + unconst;
-	size = (cache_size / 16) + unconst;
-
 	if (to_user) {
 		pr_info("attempting good copy_to_user inside whitelist\n");
-		if (copy_to_user(user_addr, buf + offset, size)) {
+		if (copy_to_user(user_addr, buf + cache_whitelist_offset,
+				 cache_whitelist_size)) {
 			pr_warn("copy_to_user failed unexpectedly?!\n");
 			goto free_user;
 		}
 
 		pr_info("attempting bad copy_to_user outside whitelist\n");
-		if (copy_to_user(user_addr, buf + offset - 1, size)) {
+		if (copy_to_user(user_addr, buf + cache_whitelist_offset - 1,
+				 cache_whitelist_size)) {
 			pr_warn("copy_to_user failed, but lacked Oops\n");
 			goto free_user;
 		}
 	} else {
 		pr_info("attempting good copy_from_user inside whitelist\n");
-		if (copy_from_user(buf + offset, user_addr, size)) {
+		if (copy_from_user(buf + cache_whitelist_offset, user_addr,
+				   cache_whitelist_size)) {
 			pr_warn("copy_from_user failed unexpectedly?!\n");
 			goto free_user;
 		}
 
 		pr_info("attempting bad copy_from_user outside whitelist\n");
-		if (copy_from_user(buf + offset - 1, user_addr, size)) {
+		if (copy_from_user(buf + cache_whitelist_offset - 1, user_addr,
+				   cache_whitelist_size)) {
 			pr_warn("copy_from_user failed, but lacked Oops\n");
 			goto free_user;
 		}
@@ -428,8 +432,8 @@ void __init lkdtm_usercopy_init(void)
 	whitelist_cache =
 		kmem_cache_create_usercopy("lkdtm-usercopy", cache_size,
 					   0, 0,
-					   cache_size / 4,
-					   cache_size / 16,
+					   cache_whitelist_offset,
+					   cache_whitelist_size,
 					   NULL);
 }
 

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
change-id: 20261114-lkdtm-usercopy-wunsequenced-eeec86ef6500

Best regards,
--  
Cheers,
Nathan

