Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773854;
	b=vkd/O9LqE77mFFE29jpjQyEQ2Jbyjv+7V6bkjMaSRnc1HlRX2ZofnwTZPOcL6gF5NVzw
	 whKOle/zgY3gW+TxDHaI96Aww1U9KjSDkVzsBN42BcX4O2O5ukawWZMU79ofXXSm/aYVs
	 5ikXDKygkb15Tuu8SefVia9WwnJizCKHOPEPm7p0IrNwjqiUzGZH0bPlsjt+25eCqLW8N
	 GG0iINqiYfA7CFrdhclUFXanPjz4kdLuC/9rumlvpFyRdSIu6pgrglU93QkmeSuJrh2FK
	 JfGGqgqP2nay5SoA0Uj6s60I9+VaRgoMMjJQOjnkRcqRYGLktPrVz/cm3exSTLMckVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
	b=VApcqkmCRfdINnYH3nZluLqepu66ibeKvLuDCoRteUuzIwJraDcZc3GKLW3ezwaXK8S3
	 Wdh9F5F8dqmU0S+PBRGOpE+Ufe19pSPzi/WzxaovOOHUjnJD7rD260LWgml3M44qvDGaQ
	 Nu+bx0wSIM4TSQCkiekQTw500lfVFl7/8U+29Xz3dZ0H0Wg+43bMxPR1sKRxWa+hqKC7i
	 k4aAagxmZkhlUjkClK77aSDE2ASbYa+AcBSXK7yBDYtSPxfRbAp8czwaWhd3Ekeaws4wN
	 rD65GxCdicCZXDxOvY5Z51fIIe49tBu61p1lOwCIIwHcZXW7R7XZjRrrSnXgWBmX4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ghm/XOD6";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F5606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A7F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghm/XOD6
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14fc585291cso370156c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773854; x=1794378654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=ghm/XOD6ujPLQihO+KHWRj6ldK8L1dBP5jTWwWS6woQhENxcApbdzhvp1Wj6v4P8om
         ITut3zVMqYf/Scsl8DFAlm69c9PrwbbrUfBS5OagQizpIzR9yFWKyMlSdd3aoe3msPVf
         hmX/FVpWr+9H+R7ID7LcY+QjG7UHL1+M3H5joLlYmjXp+lZRoghzdOFCZjlRkGxpQv6z
         saaKmnrLcxovWeHTUb6OnyZwmto7wFJKnuBGOaDPjz0sXXdzKkrmva+p7P9oEkWN515R
         ueiPfoGB7EKHqm+o5VE6ROTzqx8YJZRdeEZXLOceE+wjcVc5TIwUbgimyZGfjTwGzysq
         8O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773854; x=1794378654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=fCGTxy1jEXmo26pArcFhy2GEZPs5SxOLxxGVZRjtnu2I+FgI/JIYSH5MpdcxNtte50
         b62euOoPmEQW1jgOOUiD27AE+0BVjJFrrJCox3s8eH3+D3Paav5L1SyGSj74kTHTYbkJ
         F3q5JT0HKT0shfvpmetTLCgWJyxLrSTE/aXiTxSyGHya+mUbW8pYQNxBwg9bcyNuzt6E
         gEKCgnGHCFDhBKf04TUf0x//XVDQwL4ZGUv3Gro1FWTkzrZ+MCjOi9jZf0KhadL0Pug5
         6sPTnrt/7KV+PvdSg9LigJhaJ3nufwJI75pTyhY0zvSUrm2aGMd7Ip1EXpmg+Hu7hb8v
         /Fag==
X-Forwarded-Encrypted: i=1; AKwUvByAmPVpe6ld1343xqyYtqvYpX9vhhOA1WKhU6fFbqHhYkwQcqGQpby3LIZ+Fb95bWnLndxk0p8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s0zef7y2sHujX+Bx29hkCZMwD3+r124e/z2cYS2u4C1TFT2Gu
	xGSn/qtk5DmCbZIe9LIjQOvA4MV12xCPHTWqMkcJYp1p7l5GIi9landm
X-Gm-Gg: AYBFou2U9GNKv2yaZQ5CIiGtfezjRwGyC830x+ab0JJMwrkp+i74MN8jr7IficERXOg
	KMg+FYSGpH304urGPqMRVLlwWIZVLS0CDZTpAfOp3dX3YI1SoamzJ1DCCn5yZXZQ+8WZQjRuV8i
	um3Sj+HpUH7aJbKxIeoZPTZsK40H5WG/q7VBb/aODUTFOxKZxC7zyRUW1ozcljGlFBYaqJdACLL
	f+qgsLoi0C4FMvzu79y19Ui/8OlgjtPboFe5kxkSHCxbUwbA/YEBMC5cGbtlwwVQ8wC1D3Pbcu5
	44PLUiIkz77g5QmVYTL5VHCktu7IJFfEikhfrpG3lmbO52N110p2OC7soVFlx3plqp7w93JFzDD
	+8WJ1GOvpE6oaJp7IPWafOT/hZkH6QvG+EgdmdPNN3Ko48x8T8TaksikANcQG75f1ChWADaiond
	7YUzYWGW9KZveNaGZjcXK+5ayZC/Xk28rOAGToS/dZcuA0T9EDG6eOsT0EEYiskR2nA0OW0gUNO
	7c7hy0SlLhs1LeXNo2+2djxnvimWT+RHjomzWTW09Aiuf2v+gwdXCesg3KkFJypVVT8SWLlOuMh
	SUAdO9Gh4XECPfUYHI+zpXQw
X-Received: by 2002:a05:701b:455a:10b0:1b2:42ae:94fb with SMTP id a92af1059eb24-1b242ae963dmr4316991c88.37.1793773853561;
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:39 -0500
Subject: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
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
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

list_splice_init_rcu() makes a list look empty to new readers, waits for
the current ones with the given sync function, and only then links the
entries into the new list. The sync function takes no argument, so it
can wait for RCU readers but not for the readers of an srcu_struct.

Passing synchronize_rcu() for a list read under SRCU still builds, but
leaves SRCU readers on the entries while the last one's next pointer is
moved onto the new list head. nvme_remove_namespaces() does this today.

Add list_splice_init_srcu(), which waits for the readers of the given
srcu_struct instead.

Cc: stable@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650d..d4dcaeb83e2b6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 void synchronize_srcu_atomic(struct srcu_struct *ssp);
 
+/**
+ * list_splice_init_srcu - splice an SRCU-protected list into an existing list
+ * @list:	the SRCU-protected list to splice
+ * @head:	the place in the existing list to splice the first list into
+ * @ssp:	the srcu_struct that readers of @list use
+ *
+ * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
+ * instead of RCU ones, so that none of them can follow a next pointer
+ * onto @head.
+ *
+ * Note that this function blocks, and that the caller must prevent any
+ * other updates to @list.
+ */
+static inline void list_splice_init_srcu(struct list_head *list,
+					 struct list_head *head,
+					 struct srcu_struct *ssp)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *next = head->next;
+
+	if (list_empty(list))
+		return;
+
+	INIT_LIST_HEAD_RCU(list);
+	synchronize_srcu(ssp);
+	ASSERT_EXCLUSIVE_ACCESS(*first);
+	ASSERT_EXCLUSIVE_ACCESS(*last);
+
+	last->next = next;
+	rcu_assign_pointer(list_next_rcu(head), first);
+	first->prev = head;
+	next->prev = last;
+}
+
 #define SRCU_GET_STATE_COMPLETED 0x1
 
 /**

-- 
2.43.0

