Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816966;
	b=Svmv3ECgjV+QbpfN+KkNaKldaOyKL1z9wQlTu+fluYTEFeyNGbkWOWtiWEpVQGGtjnUn
	 GHG5QDUZFjipEK6ZEWnppVbSklKC9lNpvri4m1EDmTzrcY/ihMrpt/d3O6PlFXlAm+yb0
	 N1DKF/atFnn1prtT3nT1eLtjk+o4Vyp32tYmIAdQ44BHtug6hV2Oyu1Y/fw4nG9aLkc6M
	 dI6u5kbJ8gskHPxYk5cM5KPVidJEMOZXtB1vKyyFfdEep6yLKSlVdgWlZCFl8hdPMl7dM
	 ygk2dSETJBScdySom4M0mZntiXtHCN/VAUDI89KO3TckQ2MD0iobiISJ5rerobop+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816966;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gEfC+CLV/ed3wzGS9t3dFfdDmPtq49mLFwiR4hcK464=;
	b=1Z3rtd1xrJ1CEHOCz32cEr/f0uz/lRyA+HJHytreL4qJaTSsgfSgoCD/Hvy4Jz9rAMsL
	 cH024w6XTlJqGOrSl4O/TbxUJgzBFYxBjeLs2rKU4ugMxYv9BsRo/xQUQb0liUPAyPPor
	 p4lIo06aoRuIIRYr32UDCxiXeNUD+wNgzLUh/JxUDG5X2ne56TR6kJ/9h23bY6v4X66z6
	 NayRn6GYc01foZejHXgbUadWx1cV5M1+lpkvCVRQR1TRGxLSNqZOigv8xljZtkxWmmD6u
	 Dn0U1YkwhfivPJ/uGzcmWM3kMmgUIf0Sx2NySsuqzyAXOkmFO/DNbnPWnahAaIz7KwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dfPIR6ZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAC606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dfPIR6ZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575441F0093A;
	Wed,  4 Nov 2026 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793816965;
	bh=gEfC+CLV/ed3wzGS9t3dFfdDmPtq49mLFwiR4hcK464=;
	h=Subject:To:Cc:From:Date;
	b=dfPIR6ZA+olzfWnKPqFJndsw3Dvx2SEcj2KBuEJxzgAVrMSwEo8I+j4e9RNfXVIug
	 4iSejCl7eQRzo1A0JiK36OI2Dkzsj6AAK1e2+anNCzSyXD9Z91loSLo58ewM1reKyI
	 xQEr6UwFhzz0IATfVmtUvGApTpC7ko40Eojtqy7o=
Subject: FAILED: patch "[PATCH] smb: server: size directory name conversion buffer correctly" failed to apply to 6.6-stable tree
To: coderzeng@hotmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:29:24 -0500
Message-ID: <2026110424-submarine-stool-e2c1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f1f37834eaba5904103af1f18afe3510c7e9dc71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110424-submarine-stool-e2c1@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1f37834eaba5904103af1f18afe3510c7e9dc71 Mon Sep 17 00:00:00 2001
From: VeroFess <coderzeng@hotmail.com>
Date: Mon, 26 Oct 2026 15:01:03 +0900
Subject: [PATCH] smb: server: size directory name conversion buffer correctly

A 2048-byte ASCII directory name needs 4098 bytes when converted to
UTF-16, including the terminator. ksmbd_convert_dir_info_name() caps
its allocation at PATH_MAX and writes past the end of that buffer.

Allocate space for one UTF-16 code unit per input byte plus the
terminator. Use kmalloc_array() to check the size calculation.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: gpt 6 sol with daybreak blue
Signed-off-by: VeroFess <coderzeng@hotmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 2dd91c9e956a..5037f37c9226 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -296,12 +296,13 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				  int *conv_len)
 {
 	char *conv;
-	int  sz = min(4 * d_info->name_len, PATH_MAX);
 
-	if (!sz)
+	if (d_info->name_len <= 0)
 		return NULL;
 
-	conv = kmalloc(sz, KSMBD_DEFAULT_GFP);
+	/* One UTF-16 code unit per input byte, plus the terminating NUL. */
+	conv = kmalloc_array((size_t)d_info->name_len + 1,
+			     sizeof(__le16), KSMBD_DEFAULT_GFP);
 	if (!conv)
 		return NULL;
 
@@ -310,7 +311,6 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				      d_info->name_len, local_nls, 0);
 	*conv_len *= 2;
 
-	/* We allocate buffer twice bigger than needed. */
 	conv[*conv_len] = 0x00;
 	conv[*conv_len + 1] = 0x00;
 	return conv;

