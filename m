Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0E385529
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201219; cv=none; b=pjRlIh0OXy0J787oqu+sW7W/bfvWkZXVlqXpswnOhfACdF3SN6SPnWKb5FOL/jEEhWruvQxOpxdnDz9Ujb9+ecBBcjZeIxq6yGMMZqsr69Japs+ATW8sQ3y1vv/nbOuJV+zQdXhCLK1uN1VZYOGvNyJ2prkVKmA0kSdV1buM5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201219; c=relaxed/simple;
	bh=03d2guiWqC1X1aeqO35/Sp8MAuCwdb5LIMkIfyXcbdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR9nhiNtpKkipK6v5R0oZIfDlURjBJ2+vhiJs6qc3FzSX6saO0R4cGW2spV+s/LjVzeBS+NGU4ekxoo9iL6j9WgGk+SF3CVicyztLGnLxEJ8vxBJBwHnKJZul4tObnD9uC1jXZ78ephqJhKj4b27xt5ZRNl2lkof6xs+mHHOVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V04wgNz0; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V04wgNz0"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso725401eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201212; x=1792806012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ft0AbSsRy9AcaQSCKpocR5zMuQhawmF0bk8dwTnAFcY=;
        b=V04wgNz0yIAxx8EGVx8CPycmVz2ayi9gJRKGke87trcTAEGqZvq9HvOxbYjqzZgiD0
         DC6+tuduQuSMS3XrzVlXDiGcaION0cL+53pbU+0GexB4aF988wy6bHuWePFGXZkabH1z
         tyyOWFUJS1uFOaCE3gIwF8L6LpFSYpTHBTqWfbNc4a/cAnxnu0r3rHY3Fyb0M9oJqrM0
         FIRlJ1dgZJb4VMGHGo64kGeQu8S9MxSbarVhGNNfdM7yFJBJlg8dhSeURHLdbNitwYT+
         /O8QZMcumXWwL6mOI//NHc/0BviRRovWBXtDahGB+TiXDxF2XWSmS5dXpV2A7frb5gLv
         cCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201212; x=1792806012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ft0AbSsRy9AcaQSCKpocR5zMuQhawmF0bk8dwTnAFcY=;
        b=n/01p6/vguEwOghTBCnRR/3dQWMijnOmeVxG58zgLThw5ajor9tpuvIRYb/94DD6d4
         1fmb0p0x8sCa08I4I1xauKsggv9HsoZ7r8YW94kfNHJkc/YgMpEVzpkdvjdoMmVBTM3x
         G1jPmtNc2NDQfYzOWgxbgNJdql6Qrk2fMNMupmyYTv6V++wH5rZiNAhU+6a70JPVC5Mo
         odgBzgJpp05ZVVjZlmFQ6vwM72d6/4vI7eeyJVqRVJD2NadgeK5qhec1YfMD2nwm53T8
         B/81s6MuGNQKSEZag2T4QiN8SJIrXjLLdnOA++9br18Rn/H0yIhADvn+Lg8ubz1oN4F7
         q+8w==
X-Forwarded-Encrypted: i=1; AKwUvBy83OZ9U6QwozSIIv7Ufk7M/YfdbPVT38MVEXy82Vg1ZnWLn0yldkMyIQrnslN4msJ8eLAwTpQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIknVBkgTgOvjKoXYLP8M9FgkgbjfNPn2gutR9PuehIeMQ1BNye
	dG4kk+WP+eqsk6j4vYVHxb+dQaVypE7BmYEpS6FeuhlvMNHkQMJEteEh
X-Gm-Gg: AYBFou3vJje6Ao5fsvW1wwTlkD13VorrjJGZwcT5pzVAzdwSy5yUuYrOe15BWawjJBx
	2ULmqllsImYgW9rl56npUJTdcluxuX0HZhbyBEExXIJ2uxwPAkg5qGnSSxv8Rnh+PSjd6wmxwuq
	iRt3kd9YcJdkC77MXC8OKvvidkSq2gcriVF+GAUx9OpA3mBYXLKK8EBIVGFGtPfPgtY6fGrkLPB
	ABDhwiE158vsYnvFpPwARFHJxXT5YNS0DnKFBhw/JrAB2aeP1FHr/FwPz5b/50tL8cW/uNPd2sp
	peSpGe7qQwGUCm4BV8vWKzMFX781TMgqu9LBd9yltv9X2p2DCklz0+4it9pdJEwhKrHfz/6QbL7
	ZXKtNQJSfhWZXkmtyJ5uL6EGrw13VxHg2yXf4ZNTGd7Tq+alWmbCyozNnf8c6t/xDi9b1xsbV9T
	Mm98Ga6lX/n9q7A2dffUZrUjDxUTtX422ka4PQCa/SnKC+oZP38kiKwpa1HvKUqCVjQnm2Dzwaw
	oCZ2Ib2OGzml0eos9fgmE8CUPZAsfkxfvy6eHDRbhG2ZHnIrLy2slo2QXgnmgEQzmLyD3EE3mk=
X-Received: by 2002:a05:7022:ea8c:b0:151:2e62:fe6d with SMTP id a92af1059eb24-1851238aed8mr1925843c88.22.1792201211913;
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 05/11] HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
Date: Fri, 16 Oct 2026 18:39:50 -0700
Message-ID: <20261017013956.2440130-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds kobject_uevent notification after setting os_mode attribute on resume.

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a16733edad5d..ed08200e3571 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1471,6 +1471,7 @@ static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 	if (drvdata.os_mode != os_mode)
 		return -ENODEV;
 
+	kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
2.55.0

