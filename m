Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D783A14
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781906506; cv=none; b=dynGage1jEEWM7f8IGeGn9q3lodAAnUwZ5JuWtFe0jnkhCmlgNj18VQdWWOL+SHuDti6P3ZH2NQAfna2ZM7jGrlvBKRwAtm9CBdTigGaV7AQ6+AVPcVay6jEsecOvFf1aED7MMrjHlryp/d/QBu06CcODMROho/zx6wxKiNLkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781906506; c=relaxed/simple;
	bh=E59fOlkjiRmKNrpvyNju4xihCzLoU7PNqA7gLFYmxEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHmjYf0PLBDnidwBAuH9fiKMGeVeXE3hObL7xjBwZ1xiBEZl3KvryXipRG+v8z+EmJAxCw3zRmQFIS+ZVhrISsoPO0Uow7KQGJzn3H36oBSP7Wxrh4CxSXeRRD2+yduqNnHYl6j574oouO1osSW1q2Y0yc6nMfGtZn/Dx0WiGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVWZ2DJf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVWZ2DJf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so27000915e9.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781906504; x=1782511304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmIEX6C9YTwBXIiTp9Q/p2/WVMpmkEt/6TPMjICMgDk=;
        b=qVWZ2DJfgFCAwfcqo6H1R4Xy6fnZuEq/LU6RMQ0iY8qlGf4fdiLwot1KZL9a9gv2FE
         S5GWWPx6FZ+SBtvzmtRHSy0a/C+KvmAILAaGIxRRGAgW0LgBLZu2SejzrggJE1cU4gT7
         XqtvAV0Wvw8o1/ODy/rgi6AZpQzxfyETu+ehn25AmPkckI4fw+ND0KT/d+AuB1zZOVFv
         fFtkDg7HIlqgdcoSm/5uixNZdK7K6oJI9LwQcfbkvaZdliOAv978BlbPwk5emKwLMMRV
         e43SovL3SWPJExenPjKICWCzKyzFJAMVXuVv3j2wgrCOBvAG3UFgbfDhyo/M/sUXoRze
         5qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781906504; x=1782511304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmIEX6C9YTwBXIiTp9Q/p2/WVMpmkEt/6TPMjICMgDk=;
        b=Zxi53VPOfjJpgqlUpW+DjdffD0hueM2/4MYsgRhyZdKOwTxOcHiGNR67zSf5WBLJDq
         Bw3LpIQgzhzsC6qNfgt/+j9gZDbV9p7WKu84qDHCXmFvfmdTlkv7SpXT4sbWs/FUg7Mj
         Xa5GX1pIO+BSrUsYYlso9RSRyEhdIyWDJR2yo9Ta6PT5s/UrrUG7NXcJHbg3QS0TNMNi
         /5zC2H+gc3DJqQvrZ0Gt+z/Gmz5NNLnSemSnlHYlI6DHGIEMFC2WtdW8f6Dk2tnKm2gp
         Dbb7kimd7cxytrFjnYKh697mocarRprsE4xpzbsdwEmKis1luNfQ0EhkX8QXgD2yzmXO
         2W8A==
X-Forwarded-Encrypted: i=1; AFNElJ+oChwxNkdkURPzOzZPbYKcOClze/wXK2pYalVj4mwoONM6SikrnnAGPOn68acmDnNaZ+4zQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMz/UG2v6AjltVwtGP0u7Dryw57Ub0FxvYVe43u7WNzZJ4bWp
	H7gdAQ9PgDbYJ4ixfevqePNTOWDC6Opj7w++RMMiBUbaky8wccTYQ5o=
X-Gm-Gg: AfdE7clPGOmwSJ4KuT4wTbNQGHNytEZxuVm4g95DT+IdjLNqQvCUDbxe7AvzUuZ/GrE
	PMIK5Eu1v7c+PkVZWs4AwlVFCO5GKC49gP6NF6ey7ufMqWynU4oxwfwje68jqmMkC/b878p7fo5
	w993lNFoM/Q5SLCeLhJS652hpMqrGP2A9jbBoG5d2MNX4/e6H49JhEYaG4OGgZqORkr1VTKfVV6
	u43qizAjnP2S12L0IJF+vLEVq1hD+Vu/xHz9yasNr3GCG0LxJ6ERHHJHYiqwHoZ+rVPmAeunqeL
	gy+1oW/LR8RdgHY2R96lyWR8du4xvgNQAuVJEzMLl2Vt6oZVCt91sdqBTjOgGolzOYv1hvGzh1E
	/MP5qHEF0lA/j7/x2aDuAirPamAt9Se2MMClDxKqqz0Ipxjf4S0EOuVs4YA==
X-Received: by 2002:a05:6000:25e6:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-46568f0843fmr5868475f8f.0.1781906503592;
        Fri, 19 Jun 2026 15:01:43 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm2247803f8f.21.2026.06.19.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 15:01:42 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	Todd Kjos <tkjos@android.com>
Cc: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Li Li <dualli@google.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] binder: free fd fixups on superseded transaction teardown
Date: Fri, 19 Jun 2026 22:01:41 +0000
Message-ID: <20260619220141.3193697-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When a TF_UPDATE_TXN oneway transaction supersedes an outdated pending
transaction, the outdated transaction is freed with kfree() but its
fd_fixups list is not cleaned up first.  Each binder_txn_fd_fixup on
the list holds a reference to a struct file (from fget in the sender
path) that is never released.

All other transaction teardown paths (binder_free_transaction and the
error paths in binder_transaction) correctly call
binder_free_txn_fixups() before freeing.  Apply the same cleanup to
the t_outdated teardown path.

Fixes: 9864bb480133 ("Binder: add TF_UPDATE_TXN to replace outdated txn")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5fc2c8ee61b1..955bdfb4d907 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2920,6 +2920,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		trace_binder_transaction_update_buffer_release(buffer);
 		binder_release_entire_buffer(proc, NULL, buffer, false);
 		binder_alloc_free_buf(&proc->alloc, buffer);
+		binder_free_txn_fixups(t_outdated);
 		kfree(t_outdated);
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
 	}
-- 
2.47.3

