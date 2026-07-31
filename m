Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CB4334C6
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510285; cv=none; b=TP3g/jDlam2lTu+6TUT82aSCd8vJC0kc96VO5wZ/HKk2a3MbzSqfsyJj4tx6goX15XOOlHlabUcAEgnGlgLfmHNJgZeuSPs+FN16JBVufQS8BBS4ym7s6MviWBKN9hKERpXbUtPUFaTfgAMgyIPjsBvj/hDk+QY5nzmLqaN1Rqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510285; c=relaxed/simple;
	bh=9XfU8m9tSyay/7H/o/K6AIyEgpODnHxgJIw/8azuWlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlhVRsl1oAtIiINZ/Tdt7TyexMZLRVtiQSL8mk7cPFKZoF88ZZ5lZwOmC+aPiTZlbYJSiwI4gqUk5NYajf6VAKCBCxAfR0YOP9TwM7SdTWNUzM5gJgjw3CHYXlEK0TSzw75AiBffq3cTU+2fTeFSNUolIt9e43KKz6Jgneo3hjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUr7H4e6; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUr7H4e6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6681e786b81so148601d50.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785510282; x=1786115082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEC1T4rg4Niur9mZ8qTP+i49mzDy92w7tFYDv9o49ew=;
        b=SUr7H4e697+V/jwq8y89EJBxfuV4MCYiQkitZ9qQ9F3Coa93ZTuR3j3dDLUXE6Tpb6
         rq/nQY1KtlO/gEMvcLtYQygfCNx0WoimdpoH+VMe/e9N1WGzyShdGAOaZcYJYHo3h3Tk
         7scqqfJ9rD3TN/xbPXXgESF+dDogfw+/JF9IX6h6keUu5sBpIMcva//3i0kgNrpGakv6
         Ka2w83H2qoihShKgtmA8Zf0EcVF3QbORpUhfsR6Nsaz0B6hBAKPfB6Qf43PHlXVPxvS+
         Wun3j+kARZjwrT/FQHOoigGnC4jpVt8Op9IJZ/zN264k0X6H5/ykhdqRlQsRsTnAr0cj
         hHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510282; x=1786115082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEC1T4rg4Niur9mZ8qTP+i49mzDy92w7tFYDv9o49ew=;
        b=ZFl1uZg+C6bSIbKAIDcv6YrzZvhpqlzNZGrbYa7KrQdg4gKZ+mBSLLM4nreaGjKcP/
         P4YEeYkHEOnfmc0vDDJSvJj+yO8yxqbVTzTwarVwivIVcJo9Vb2n7BTHZi7gTp1SZZgr
         YL8kwDuDCwKOCW12UHWarptN0jwfFY46jeuFsoJVUjPqllUwIEmokx/usC0hUSTT3xea
         ARW2Vc6nt1Aj4EfPUmf/s7WScOl3vmP59OLZbAR6aSyikXXn56oGKNxv9ffPj9juHV31
         S9rZUN2tgtvYVc3poDL8DLkTcFFQcL4oO/hF75mIx0TkPUqIeIcGwUIQEiz3QLGdoeOy
         O1aQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgJvXXUUUdXYqeIZa2lg9bkHQL9xY3ZC51mJREEm0oaa0E0yehKwxakWMQvSKTaPP6YXor9AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfPZSM763efbCGIO+nqqAljIPaZ6yUBNfhbpr1m4LHq0eAswL
	Apun1pI9rNyAwxPUnyQHdIgcYHNpnktvW4EKfJoVCzd70nNKnSYvOvqZ
X-Gm-Gg: AR+sD13BAZOdIM47t0HJ8f6Z0D2KkbtaY2d82IMpsNuQh8QpodLFPqOvjOZxGfFWPji
	jk+OE76Vhf21iAKLk127uxoHAmy9MUm8+kglGMdhLhK5E1d410hYSucmczNJGKs/bigDTfiU5v+
	++/UQi7iOR3vcsXgqcRgbbzzPwaE/94m4gU9T2ddb+6Ku0DyIvsET+nvi06T7/Iwq0TOGcJUq3o
	Tw9w8rFtdLu4WjhzMJnqC3ZNxrQMq3jwJgliF7c4Nk3VmucU6TUqoZ0epRtKu1RVAOs/fbGSn16
	xX1FHZsO8HvK5bMxxlfE4WycJQe5t/HUcNvDVWVCoJ1ZdnJ43TfIn21HFBrogADf5tKMY8WENoG
	ojJdiouQ6n4o/l4gtEHcaLSnKxogG/uUa5/Iwu3MIRyLliR4oQtTyh9ClKt4Hk8W2LS75uHjann
	QdZQM4CiRZM8XjyKyyRi7siHU7Yb2qiNlpMEPo7fLQavL2trMq8r9gGisMAWQNXQFup0ZAr7iuq
	0u8Lxr+lwKkmdg1ZYmk0UavkK9LPCC/UeBtAvX3RZpmzoEuJWTWPpI=
X-Received: by 2002:a05:690e:4544:10b0:668:99c7:2bc6 with SMTP id 956f58d0204a3-6694f23f018mr216528d50.3.1785510282473;
        Fri, 31 Jul 2026 08:04:42 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948cff867sm696184d50.4.2026.07.31.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:04:42 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <mgr@kernel.org>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/9p/usbg: fix descriptor cleanup use-after-free
Date: Fri, 31 Jul 2026 23:04:14 +0800
Message-ID: <20260731150414.3135662-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb9pfs_free_func() frees the f_usb9pfs object before calling
usb_free_all_descriptors().  The usb_function passed to the latter is
embedded in the freed object, so removing the function from a gadget
dereferences freed memory.

The failing teardown sequence is:

  configfs unlink
    usb9pfs_free_func()
      kfree(usb9pfs)
      usb_free_all_descriptors(f)
        dereference the embedded usb_function

KASAN reported:

  BUG: KASAN: slab-use-after-free in usb_free_all_descriptors+0x138/0x190
  Read of size 8 at addr ffff888106a73088 by task poc/95
  Call Trace:
   usb_free_all_descriptors+0x138/0x190
   config_usb_cfg_unlink+0x1f0/0x2f0
   configfs_unlink+0x321/0x6f0

Free the descriptors before freeing their containing object.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/9p/trans_usbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 419cda13a7b5..8c2f0d8592c8 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -725,8 +725,6 @@ static void usb9pfs_free_func(struct usb_function *f)
 	struct f_usb9pfs *usb9pfs = func_to_usb9pfs(f);
 	struct f_usb9pfs_opts *opts;
 
-	kfree(usb9pfs);
-
 	opts = container_of(f->fi, struct f_usb9pfs_opts, func_inst);
 
 	mutex_lock(&opts->lock);
@@ -734,6 +732,7 @@ static void usb9pfs_free_func(struct usb_function *f)
 	mutex_unlock(&opts->lock);
 
 	usb_free_all_descriptors(f);
+	kfree(usb9pfs);
 }
 
 static int usb9pfs_set_alt(struct usb_function *f,
