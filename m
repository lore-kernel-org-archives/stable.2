Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2924E4C6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447320; cv=none; b=YTJFACuR3QbXQqNkr5JIWRMHdO3QQPYcykdlqG/spkFBRBsffgn2doWU+9AYSg4Xui+oxEzuyycaMzWDDPbzA7FP5A20ysetlX91zSNio+ywlGWN0HW0CR8SCSe/NcytuPmrI54DVEqJ3OoI3fCMFj5xoAg5T2IACeMuZHvJsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447320; c=relaxed/simple;
	bh=IqP1imwtGz7a9K3TiEfZoU4AQjH78AshTYm8QenVp84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNZoSDcTbWm4DvDTdQnBMdQ4/6YF2QanldfDlr9uTKhz3rhAF0/4NoiQKi5qmaHSyK+dnXFhjEyNpFPDv8FA2+hiVqpwCiycaEp/3YYcUfUu6nfqQK8lPQWgmmBNmeD0SpkYrANihF85qmB+k0Ltzhuh7NUx3Jm7n4tRJTB/ao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IOdrQv0+; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IOdrQv0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447289;
	bh=59XJiLVicORzxorjhxIXX4TlshkHuTgFbEEKmjOzDfo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IOdrQv0+y4g/vDErST2dDIlG3xn2ARVbg0XYwX99hdBt6tLb4hX5uku0ySsVCUh63
	 fZnnefEGfnpZYxxcppf+uV8CwPTJ4pHNhjecIsj6/WpqlwWbBT36v8GkFmfRPlOUUA
	 a3aRT3Vi8FkUA6fI0rgKJIy2Ckge7xr8O7WKkPnM=
X-QQ-mid: zesmtpgz1t1782447280t18d49495
X-QQ-Originating-IP: dpiBTTg75hHq/RchncxkOYd9olGUHr2zgznJq0Uijig=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 317284540912012364
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 5/8] eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
Date: Fri, 26 Jun 2026 12:14:00 +0800
Message-Id: <20260626041403.85968-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NsgcCu4W/TOEZ8HpBwers9IgaiO1hPuM+T41TYfx1SaAXeoINfNtyzWF
	ooZeC3HG/6N8o3EFAimkfjQDNWikCDskZwo1hqoAUhC1E9eGKoyWs0hkwWxdbeu/Ui5WjiL
	dNIZIEk/S6G8In/Ti81l7bUwltqxyHKyJTk/m8HdNkDHNO+e7OuYESNqnnRbphaYQS4xxtZ
	AdmYirbz6rjVULIj8zSVaOhrG+YpydUX3ooPumruL6GFedlALu6ArBoFYlquub5RtpR9vog
	QBhJKYGAtUISWiSuE7+zjfIlzR1QGbp2V923zjwvoMoDfp4jSGkg/GYXhEs8tES6ZFHy/5i
	KVDZ/A4tGxCTtMv6DOgeKeway+riXDZ2Cb6Zpp4ghkckI2xg7mSWNw/cCEOqAP91iF1ghR4
	JE9VfwtXIVzO/DL8Np6Kbx8jkpQQfJd0kwT8kASCKWCsmb/nHKn5PjVOveAod30zwotUQZp
	oGe+dVB8ycf75Fz87x0NeDHZrLEpRAGft7pECRpgoR51kkI7zE2pds8HGYBP73z/JJ3dYtQ
	WK47sLx1QTyE3PIj1PRnnM/FRTgS1rr4Ex2ln+l9aPtYkKMKtnarOg5/GzjVYHy3Nucu3U+
	4KlVZdHVrDd7XrBhgqScSPjsY23coeMhS1spMsV+tCUC6kCsFNj2RG5Bx/hAadRO45S9MHv
	BWZY8PGY5Smw3MdDfi3hPhmLqMHc77fTBRGnhGKap49CfL09T2fEvO8iHnwxYXqjmmUkuqV
	t6uIUND8K4RI8OwdYN00/DSKLtgpYlkb+IhHTXZOoIQdOPFJGzXRcdmoIqf/w2L/KbP+wAx
	Q9lIx8lMqi1axSIUQDspuHcE0sievqZ7St7Swdn4/TXvqcWGWc44k/RWgrZXPkCkkEG7RaM
	ZVa7nhO8FoJJpfVkFTKlruIR+orFe3G79KfkEDWpHA7m7dGSBy6gKIQ+8yIdN7ZSJvc5AGA
	lBQPqSj7z5P5uIJTVfhvn9GlK+NqCOgbk6Cp/E5FgAGvIlNxX8HbKJ9J2gUdxXjZyFDS673
	QSPRj92S2UHRQXlR6hjtOBTkP7kMAzzjIGIGWLKeNzu/RehskBIB5WUT7snDJaCUUnwudIn
	HEbJm1pQmJg
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0feaf644f7180c4a91b6b405a881afbfd958f1cf ]

With __ep_remove() gone, the double-underscore on __ep_remove_file()
and __ep_remove_epi() no longer contrasts with a __-less parent and
just reads as noise. Rename both to ep_remove_file() and
ep_remove_epi(). No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 766716c2fd92a..0a54a42263575 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -719,7 +719,7 @@ static void ep_free(struct eventpoll *ep)
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
@@ -743,7 +743,7 @@ static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	free_ephead(to_free);
 }
 
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 {
 	lockdep_assert_held(&ep->mtx);
 
@@ -789,9 +789,9 @@ static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 		spin_unlock(&file->f_lock);
 		return;
 	}
-	__ep_remove_file(ep, epi, file);
+	ep_remove_file(ep, epi, file);
 
-	if (__ep_remove_epi(ep, epi))
+	if (ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1013,8 +1013,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 
-- 
2.30.2

