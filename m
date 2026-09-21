Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053351FCCD;
	Mon, 21 Sep 2026 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029588; cv=none; b=TQVoFbhyr3v6VT+VAJhOjyb+PLJPpeXGcb1Pw9wOz4DJGCI1UpSXIgv7PTnoC89rNTXRyryTgZleXxen6Z/EW+3amykTmgPAmrRxum/gT8vTHjaXoXiqrqNwS+l2EnnEK19pFn7nwFKEdNuAQ00Xdok17Mqjkn0k/zdt+eg5bWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029588; c=relaxed/simple;
	bh=a9VaJ3QSuYnRcJfJa3Qiis5x7rXIMRzgITmGIITpyJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYKpIPyf0XBWn/SyV5EqyDGv6rCiTZogFYwSdnToFLMjNxodtk292bj/DxGcX3yuXvXyxVGk8vNbsEmLBYIqyrbws25VuodLAI1jqvKFjyHwyf0C6YOCdTc960FnyQLETzzOk9yD4mITk3+sl+SQ5qo7X07bgISl7z0siCgse7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGTrE5Pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGTrE5Pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E818B1F000FF;
	Mon, 21 Sep 2026 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029586;
	bh=+muYbjwy3j2gZE7/fS8OhPeMUFv1qoJ562D9mwJs6co=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hGTrE5Pn5B9decxeUJq9FtMhrpAL4u5DkmcQe1RC8tnWZmcbSNdQQN1CBgJSacHsR
	 XKPENXDRUswiGWQzXN5IIT+2NLT60nOsz1+qzh5BsH9WrbzDiolL1zAK5UVd6sw4Ab
	 JImWT8TvVbG6DB3A4Q36zqeznsBGIfX2xJu0WGA2PW5v5xywsuMU0c9W0GRffVbjFL
	 4HbbBYcKcHYZClljz07JCuZG+YikLFumOMLVnAzFuIE1uVKK0+SQMZBAH8ZHTJe2/X
	 7op6mLtN+udhbmK487OravmtuNPUUwMk6S9oTgBXbKP2rqpb2dnYmlSV0pG8i5GATp
	 BGU+NAPr4hZGQ==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:58 +0200
Subject: [PATCH 5/7] net/9p/usbg: fix out_req buffer leak in
 disable_usb9pfs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-5-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=mgr@kernel.org;
 h=from:subject:message-id; bh=a9VaJ3QSuYnRcJfJa3Qiis5x7rXIMRzgITmGIITpyJw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8EL37t8jJpHsHtoku20l3IlgJAU77v944bp
 7r+8Fa4+4OJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvBAAKCRC/aVhE+XH0
 qzKzD/91PJ3CDfE9AJHR/gOsNcixWdfPwSwjgUAUNt95ZqGpal5+lurqktsWvvxTjur28qj7bCz
 iGh0yTvQCvONHHLrYTUoxs8BhGQGejNMQY79stodoSJJEOrkP350kYFVpF1IXwOuSsoVDW6NwO6
 BHNmh3eJaFefYDnf1FgmIrViNjaK+DqCyxc/kbg9sbxrzbZn9pJoL9OhBYnhRYN4SHoMTGs81qe
 1r1Rgl6FcpgbhRb/YuHgCYy/au5ErWQ+bQzYP6npYieGIEUtqp24Rv4rV157SnjNwDiTHF1jOCC
 Jmy21fPdoVDe60PChVdEuMkitm7O9sCee13bAHhsR8h2Phcoc+JyfYo4D2djORcZFjXKBTii13N
 lGYubglkuYhHWOfdD6iQwX4wGfxj44lHU8kMKT8PO3kCv3ZsViEW3DKx/txv64IaSbmjFl8Q9NS
 /15F6Ni5jtloI7t5gG2xG1UBC7NSTLpedkiBopa5aKJIJVt9hNQ00oI1QkdF3GxjBwZbfmRgH2S
 u6VpkN2IRBX0XNjVKE0Udcg+RjPsFek8pMbBthJ8KAGpXHp6hSeGEqXuEPtsEF2iGR0T9Fpx1c2
 Pt7OPuN0ORecSXHkdYg7U4c1pVvHq0KihDMS5RFskaWiE+FCL+twAxSBCkJzIltj5pbXqb+XEsH
 4gVG28V+aTnTOSg==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

usb9pfs->out_req is allocated with alloc_ep_req(), which also
allocates the request's data buffer (req->buf). disable_usb9pfs()
frees it with plain usb_ep_free_request(), which only frees the
usb_request structure itself and leaks req->buf on every close.

Use free_ep_req() instead, matching the allocator, as documented by
its own comment ("Requests allocated via alloc_ep_req() *must* be
freed by free_ep_req()").

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index af113746d2fc..9bcad638d827 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -284,7 +284,7 @@ static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
 	}
 
 	if (usb9pfs->out_req) {
-		usb_ep_free_request(usb9pfs->out_ep, usb9pfs->out_req);
+		free_ep_req(usb9pfs->out_ep, usb9pfs->out_req);
 		usb9pfs->out_req = NULL;
 	}
 

-- 
2.53.0

