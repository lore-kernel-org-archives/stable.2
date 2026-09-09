Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311DEACD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914284; cv=none; b=LVGlrIgPtxQDTniEs19MVcToApq7slwflPgm4KYzoovXL+Ywht7XMisT+/NdCqajh+FXHQVQU6KHHoXlBGeMci3IpnD7tAslZqpmj5cNECrWfpFn/fg7qW1EPv37SQQVbSAm5pCbs+qA72QymJeT/9haCOrZf3SeFFEREzoHGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914284; c=relaxed/simple;
	bh=Ji+sxRrwnF6UzCYBAySsVKjKB1T07E2X1AlQZTBvUFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHc/ZBRy0WGPRFNAymlXpj7HHG/SGcwOg7BY/puyfRtGzbFHrw65lRCxyS6f84XZ3/yNTcs8BZwnYJAq/9zdCXFRu4YD2lJJeIzjOdh6JPKytJ9Ix5N3cotkDWTucAAunIvKKI695loVA4OcsOZn+B/uNjBkgm1oDuT5MnQ5ZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWj13j7Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWj13j7Y"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso2831996a12.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914282; x=1789519082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+N42okI1Wy1E3qltvnDBLmtHk/vIG4wL9iomvsmoyUg=;
        b=CWj13j7Y2t7pqq0nrqA41Ndgmeu5S7ZT8jDxb0OZ1N72RGpe9edCeH1vh1wOmCT3M1
         aPDxObm3noAP5ZiOd8OQsmgIhhfQ1gw+ssQmuxjHsO56/zfOKvz8z9/l/Q7+pi0hrjgE
         TiJs/Ov2IstHOIvOKjR+RVFwy3JaSxYoADV23o0ngImN3Y1k0ItES1Y3Cb3s4o01xZ+w
         JYOvZdYIJ3Xsj7jZKRzlXOK1exwg5qVjsqIg7FWjMQe5ZUFcieTxY9o/ksv/sSoxr/yl
         L7ay3/CK6at5vA6NAbCtTd/VJUBM1UltS2U6LGRY2OUjce/pZIhshW5dWyc5apX43laG
         lLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914282; x=1789519082;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+N42okI1Wy1E3qltvnDBLmtHk/vIG4wL9iomvsmoyUg=;
        b=fC4WYk5LzfNDz+c2brubX2qLF+itqNytD6SwIkQJtYTyaUewfphKbjLShiH/IYXcNn
         1XW1qRQthjdrDtXL2CjIPVFp88QAo8g06DcMj7iSmYf0ShdgQIOmdI21z0pGqNDxxpO2
         FsCo8sxA0o10qPK4AiPCVtYpbmypVWzEMSXKzXrt0orxCvd2CQ9aNU+uOj3rVSdsHZky
         sy69Enq3dZKO3iY+uxNgWSLrJwhomQ0ONxBHvXmha90fxsgjd5DVih20zfOwdiNDPOaj
         Z4S8bO8ukyqARfPrb/nfY77pw6OGdRY1zKC4gxmKbI97z2dtiDYri8bsEXYFx1K3GULJ
         DQLA==
X-Forwarded-Encrypted: i=1; AKwUvBwCF4Iij82bEqeO4AwI14uS6+GACcgOHBIvis5koerkn34H3YDRTk6rKtPk6YDUdOuBF4kfM3Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mejc9IFNi2uwfEcUHae9gcwzRzdCIeZPasdoHkDBCKEBfyA7XV
	QNB/Nvg40snbeBTWfAAjibRsY7pMY1E2NNJgr1flHkxCyNus79WdxuU=
X-Gm-Gg: AYBFou0qhZ2MMAxrBQpVasaUxPxZeJCzClHpj4alzwX1ySRizh7XvovIpOeSOCK5KEH
	KqnjKlrxme6lck0ul0y/0VIgT3NpLygr79h30SgxTa52eUOLGO+/4T4tQ1yukVotEZSQwUFYlJp
	nsBHNefzaqb2p/owWEh/qGTko0NapFaOhiL7MvDv/ijd5EG2Wyv4VDWZYcxVeifdvmbYvha6xkC
	2TtXaL9yWST9/Uew1yYAieRmYJ/0pfGbFwzwwFb8GDdfk5TNEwLbvyXIHViXyDjPtpxSA8IlTP6
	hR4fan2tN4DMQ0W+W2xoxgY7K0sIteMNfJl15D5DD3SQBCkQIV+FHkqtle6MNYp7U3NrhHI+1wc
	hwnFiM5VegaO64ZlCa00fCCgy60OCTJROaZpcMtXxEYDbesZfH5OYQio+h0U8gaoThhZRLOr2Z9
	8WOAhHcpPlutO5UlGhoVc7KiGBI4SoJ6NcVI1lXAfKHGfzjErFzNxp/QJzcNfzwEqIzyhM1I/6q
	t5WzK4CgrwaHfEEcdhEyyeJ4n3T14odThaJLw==
X-Received: by 2002:a17:90b:2e52:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-39b260dd3efmr42715158a91.1.1788914282283;
        Tue, 08 Sep 2026 17:38:02 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39451sm34606398a91.7.2026.09.08.17.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:38:01 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org,
	christian.koenig@amd.com,
	tursulin@ursulin.net,
	matthew.brost@intel.com,
	dakr@kernel.org
Cc: Jonghyuk Kim <malhyuk97@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mdaenzer@redhat.com,
	alessio.belle@imgtec.com,
	luigi.santivetti@imgtec.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a use-after-free
Date: Wed,  9 Sep 2026 09:37:54 +0900
Message-ID: <20260909003754.1128738-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
References: <20260904080618.2098450-1-malhyuk97@gmail.com> <20260904080618.2098450-2-malhyuk97@gmail.com> <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com> <20260908104910.183638-1-malhyuk97@gmail.com> <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 08/09/2026 13:07, Philipp Stanner wrote:
> Is this an issue? A fence can only be exported if the scheduler exists.
> The hard rule with dma_fence is that all drivers must signal all of
> them before they tear down the scheduler

Agreed for the bug at hand - that fence is signaled, so 0001 covers it.

My point was narrower: nothing enforces the rule. drm_sched_fini() only does

  if (!list_empty(&sched->pending_list))
          dev_warn(sched->dev, "Tearing down scheduler while jobs are pending!\n");

and the one path that would drain the list, drm_sched_cancel_remaining_jobs(),
needs ops->cancel_job, which no driver in current mainline implements -
the only user is the mock scheduler in the KUnit tests. So a driver that
gets it wrong gets a warning, not a stopped teardown. Not an argument
against the hot-fix.

Thanks,
Jonghyuk
