Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132E4749EA
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524966; cv=none; b=qJYyMqtWVGr4pBlksxtbOC+C0H8CL1DwbrHgCbHWi2tigLiwHfpvjEACwWt1aWp2/xeNmI33xAmBiPLwFKJXIwW7GkrdctLk/AzqYvgx2IczeFkNLCvenIi7YuOndYEmkpn+eEcwWV2Duo69sChrGX9Zuw6RSmQjHfIiXbTCbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524966; c=relaxed/simple;
	bh=voXzClVd6GoXHUqXOpaLFxIV+kMvz05cQg47euHLCew=;
	h=From:To:Cc:Subject:Date:Message-ID; b=lBuIEhWKURlOqPyE975BF3m13d9DBsbj9YGwTWpk4vV6QdLS42hbwGS39RAVRXqUwNtqxHyCWQWZcJp6/wbOPavyN58ISdtrvaGvOH5/+6gNqJrN/O03PI9fp/3azx9MiFg9GP6C48gs749MivqwVFRU0iu23oYo0tdbdTGGGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=KLxLIXtU; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KLxLIXtU"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cc73e322dbso12799325ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524964; x=1786129764;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeJqJiUGhw1arV0neXDR3NmNqOCHvAXptXpu44OsOMY=;
        b=CpFlQRWtd4PZRbhh1nRF3RbJOMCUW2Xxf3FUmzfxuKcfCzhKgI5btrPqW/3KoXwS66
         n7/Fj3SDZ3DRaQYcKzHlczIPosUstS6Uva1EscJ4Wx6RC7DF64e71M4UIccjsVBzf+qE
         VAb9vuJt4trlJf37QcSDDGaS4fMOqdhoruEst+Sj9fp//BGo/V0IBs4zpB0r/3QyFx6e
         XyTdcd9wApb9hoJXUsIrwMGc+uCzwTr7VmJnPwP58O9olFW/Qt4jZfvtZlsoDfPfL8B8
         xyWnTb/RQ7pvNNkNscCsuV46nK9jWpMheuaY3JsuhBnPe/XmHBvU1bjYazSJVEj1nCz6
         GcJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhmSLQo2up6vjNBeRWZMM5D/xDS8LTdSWzaZ771JucThQlJIIBLSVD6Fc6NIKFmth2z3tNuJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCDBMQVhm41lpNZ9Ce0SJDFyGiS+pp9I5JsJ6n9tI13vKNIgE
	YtXVWfqtxJVtvsU7J4cr9BJpQWplqVSU3T+8IMOt6T+yOMdoKBya4ZC0CYEDyJdUmWQt6nt7TXQ
	uUZiJLImTLW3nZGcN3kjHJoodxSBoS3CIVA==
X-Gm-Gg: AR+sD13HGXyHrfvzLw53idxdDV9LkHhRiaiBGAw/ugp9GU+5q03LsmHWzRY0uO/xOG/
	m4lGHHcZwVUMIcg9QMk0o9MyLzjO2XBiUbsdXlBC8jG6BTlQpSrhih2wbUvL4vuywmD3EdCE8EQ
	nlQN5c/w6VapbOykwzviAWK0+xRgSsF1FLuaObrBmyDTQ08co7yGT7u8BkWtkKIxUCAIIsn3LZD
	X+5E3vSWHanKZgEc1eMiB+K8lgzXwrT2QgYM8IzW3KQnkuLnRgHlMbaszpgbjUgsYDhU24EBj7q
	Z12l2aHS3ibH0OssoEiIjRhzg0lHLmcVpYZx/7cVSTZYAyabg+FkE7BS+ZjjCZ+z/c+yeXMQsqK
	xNFVc15CplTh2ALu3v3E4M7OUnaLW9dijwmDL5VNKXs6XjwQK2TofLz/IDgnoNqOr6Qw=
X-Received: by 2002:a17:902:e543:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2d052215bb2mr10667575ad.16.1785524963897;
        Fri, 31 Jul 2026 12:09:23 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04aeb6e27sm1886745ad.20.2026.07.31.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:09:23 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1785524962;
	bh=HeJqJiUGhw1arV0neXDR3NmNqOCHvAXptXpu44OsOMY=;
	h=From:To:Cc:Subject:Date:From;
	b=KLxLIXtUuBQkEWgsiWMTEUGFGWArp153Es896sT+jo3LgpGJNvscYeMSf36hwkiF5
	 SA4IUh0Csh1ba1bBIBEA52qipRfD3rksJAPYJ2tQJ3SLtlPgC4RsrSIUhupeLZoWjX
	 GXd7TmjU1u9KqCYMyPgxrslHooBNDNavuxXVcDO5ZDfEwxOqroF86ahz3ClazViRje
	 vEeONshyBzTGL+i10r1/CK7bCAFpt7KLmFr1goF9Dy0LTjZFEuiprULdtIkdLJl8eu
	 J9i0ij9SvAnIa1u8mwYYeNrPUDTF9Aut+ZBiFDw/9FFC9GYBVzajYegdh3c8XAMI3s
	 Jm09/d0rUoDlA==
Received: from kevmitch-g-eos-trunk-2026-07-17.sjc.aristanetworks.com (dhcp-242-248-27.sjc.aristanetworks.com [10.242.248.27])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 89859C0FEF;
	Fri, 31 Jul 2026 19:09:22 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Kevin Mitchell <kevmitch@arista.com>
To: Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Mitchell <kevmitch@arista.com>,
	stable@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kernfs: fix race to increment for nr_mmapped in kernfs_fop_mmap()
Date: Fri, 31 Jul 2026 12:08:50 -0700
Message-ID: <20260731190850.235909-2-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Counts of files to be released (nr_to_release) and mmapped (nr_mmapped)
files were added to kernfs_open_node in commit bdb2fd7fc56e ("kernfs:
Skip kernfs_drain_open_files() more aggressively") to optimize
kernfs_drain_open_files(). A WARN_ON_ONCE sanity check was also added in
kernfs_drain_open_files() to ensure that these counters were brought to
zero once all files had been drained.

Modifications to these counters were protected by kernfs_open_file_mutex
everywhere except for in kernfs_fop_mmap(). This caused a race condition
where some nr_mmapped increments could get overwritten even while the
correct number of kernfs_open_files with mmapped == true were present in
the kernfs_open_node's files list. Consequently, the iteration in
kernfs_drain_open_files() would underflow nr_mmapped and the WARNING
would fire.

To fix this, acquire kernfs_open_file_mutex around nr_mmapped updates in
kernfs_fop_mmap.

The nesting of->mutex -> kernfs_open_file_mutex is safe as
kernfs_open_file_mutex is acquired last avoiding the possible cycles
highlighted in commit f83f3c515654 ("kernfs: fix locking around
kernfs_ops->release() callback").

Fixes: bdb2fd7fc56e ("kernfs: Skip kernfs_drain_open_files() more aggressively")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
Changes in v3:
- Remove stray linebreak and cc stable.
- Link to v1: https://lore.kernel.org/all/20251119191758.612694-2-kevmitch@arista.com
- Link to v2: https://lore.kernel.org/all/20260731010914.233067-2-kevmitch@arista.com

 fs/kernfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8e0e90c93372..76ade0d0be04 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -495,8 +495,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 
 	rc = 0;
 	if (!of->mmapped) {
-		of->mmapped = true;
+		struct mutex *mutex = kernfs_open_file_mutex_lock(of->kn);
+
 		of_on(of)->nr_mmapped++;
+		mutex_unlock(mutex);
+		of->mmapped = true;
 		of->vm_ops = vma->vm_ops;
 	}
 	vma->vm_ops = &kernfs_vm_ops;
-- 
2.51.0

