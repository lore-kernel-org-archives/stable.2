Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3C4AB3B5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602379; cv=none; b=oLcvEmJll7RSKbqlVGDkR2ydCoM7xv3wiJp4R3P2Wb7EqYEs1/WdvEXDhjh7kbELe1b1PvEkwyFs9oExojlKtK8PjDVYxBTu2rTe52VLfjow3fg8qU1pDtGLvAHtkdiGxoP5fhyVqupxUJuluyfhLLHWh11sa1ifgg6C1KMVD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602379; c=relaxed/simple;
	bh=2OhXfXlxGIDEVphsIawGeDZhndr5+3TI4gbyGiqZyB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9edVh/GIQJqSJuKpjwqV0dUUuhi9rB28T2n2dtehRdQR2oFP45sja51Ubuai3q63ubvfpM1V9RIdD6/7vt4a2V0ln4MG+hpWf+/kwoGw/7V8NcTWXSZw+bZVNgOwqTrvyiL4rL5QyljBXngT3l+glYggne/Kg57epbFn6aEat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzB2R6ok; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzB2R6ok"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a5e045187so141812137.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602377; x=1790207177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpu5ToiMC1D2AynV1iB9BM+jRcYbmOZxbF1W5LEpeiA=;
        b=nzB2R6okEg/3UkWKspZXxmAVwp7nomGIODrdPUp/09TW93TnR/nHATXuQWcZe9VsEH
         rSXvDZtvLqYSSg8vUhGZA4a1i/3K/7vA9YaFicYtBbwT11bnvtIcyJPYTgJ0heTukpm1
         5q0f0195QnpEgCL4d7sCstNwGtik95kc/afjm+9F8iGmKpFV5uW3EDLff9rBvnmHJQl/
         pf0o/SFxqor8GCbCE8ffZqSuL1sa59x8SV1uW5fRUIfQEKfm3Kl1lZfqTakzFSyitDus
         3RKggRPNy+nvqS67ebzQqo1kCCOjIS111XIuZUyItS6H04DMPyRKDXKGWCi85vae0zIo
         djPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602377; x=1790207177;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpu5ToiMC1D2AynV1iB9BM+jRcYbmOZxbF1W5LEpeiA=;
        b=aml4x30FSbwPsKylXyglgo+j1WKBMrE6jxWAmKyFMNf3zqsGih1vfCRHRzbI7zI2QX
         vp3gp4/oQcpF/uAvIW7LuhT86L+QcKoNCHt0on2PRvS5/MRbCdo2JRzaTIj08q9z/QrO
         dbn0NLYo0PcVgn2wjMukjXcoH0AFQgYNITPfiiH9315gp3And8sRwbF4UcAXEA+S8E0/
         p6HdhuwSkmU+Oj5EhXEnAcJxSf7nJNgX72FZ8ro6Uu+1lwEViw2JNZLyOFob85nKSLk6
         BEteTlL4EyioYtpKC6gZ5C7RKiKp3w5+v3OyiZQg3Q3agiMQwN0Vzpaf6V6BPm0EOxuV
         9myw==
X-Forwarded-Encrypted: i=1; AKwUvBzy0KmCG3y4w5piib0P9d+Qs/JUiMdVBlriW4yR9u158yZ/YgSFrI3sFjE/NSM0BpCq03PowZE=@vger.kernel.org
X-Gm-Message-State: AFuF++lNCUoRgAYY7+5lj94AFjhNCzyV/+vgpFEuhEzvR4nmP4oqTZoi
	kDQLLH8T8+x0DYRV6ePLACG5AuNgIQZcUknJ4TGckyTXBtb2UxE7H5Dx
X-Gm-Gg: AYBFou0cz/Y/bg0ECnLwh+M0brFKp5hiQmJ0Oo3VP/h87K/VkkLN1ZiuY7kQsf+4Qcl
	8YWLQ+QK+OKN8Cra3EyvZB9bFRpqOEs18fuTaLOg68WwI7tGNq7GR6RcMC4MI3Q49sGASWyPDXT
	5UMLEQcl+J0lZ/3NVdwZ6cgOOpi5X+eCdqVSq+a2dG8oZgiA/ig+GvdSOrGHdVKTib242augghb
	/Jes3VrW64eWprjo7D5XjGnf5jS598TgdypqrkAKQjoeSjPGxX4DfKCbDOE6+6MjmNEW5o1MqJg
	nLHJneahbxVD9cKDHBfk+AVet92t6mLbynj4nXBcJCm4Bckryai2vqjcJCW6dDATNJGhFw1ouMN
	V0zimbTAax5T9QNx6AP33bs2zudFQ5fdS4aVl+Pz4PTsLqDSzD7/4J/8nUwIwE1TlT20TOVYJnj
	FPjMYKCE7UjM0bozhs5io7YBs9bC6QGx8HihgH0HQEfFXHfoD+XxNQ7sLh2fS0XEih
X-Received: by 2002:a05:6102:5344:b0:7a1:f7c3:3a41 with SMTP id ada2fe7eead31-7a1f7c33f3amr1280846137.14.1789602376909;
        Wed, 16 Sep 2026 16:46:16 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1e314e925sm1533528137.9.2026.09.16.16.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:46:16 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH] nilfs2: fix checkpoint root lifetime on sysfs errors
Date: Wed, 16 Sep 2026 20:45:48 -0300
Message-ID: <20260916234548.376973-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915041206.2430937-1-qwe.aldo@gmail.com>
References: <20260915041206.2430937-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Good point about the wait_for_completion under the lock.  There is no
circular dependency (the release callback only calls complete() without
taking ns_cptree_lock), but holding the mutex during an unbounded wait
is unnecessary.  In v3 I move wait_for_completion() and kfree() after
the mutex_unlock() in nilfs_put_root().  By that point rb_erase() has
already removed the root from the tree and the refcount is zero, so no
concurrent lookup can find it and no other put can race.

Regarding rwsem: the kernel does not provide a combined
refcount_dec_and_rwsem_lock() helper, so nilfs_put_root() would need
the two-stage refcount_dec_not_one() / down_write() /
refcount_dec_and_test() pattern.  That is doable, but the lookup
contention on ns_cptree is minimal (mount, segctor, recovery), so the
added complexity does not seem justified here.

v3 follows.

Aldo
