Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808761;
	b=R1GjaYrPYbRpaqhVLAGPBDKkveOQRKI/34+lW78NBHIEqziURTg64/oImPMX+pT3zxhB
	 HP6JaZDSmyAiYAGOrf5Tiq9PDC3wiEH8cKCz/zBufBSDIFGh8UxpJ1QSakoaoID8qdMpm
	 vbBmbTScNMPKijqBqS3/AlRwakWRo+a8mVuVyRfq7SASz3dD8eiYYKJM68MnRNjRhzNtp
	 tRDIkfm4ehjLRyIhz48Y7E6jadDkeTkEQySRtEw5FGa7vtCR+m2nWVUSG3zWP+s7q64Lr
	 wHqXOth3unHmex5MrAJkVOUhKNqw9/PjYu9fl1Jb8MA0mZxqOVEmswQGJd1vNzxvF+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808761;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kcerf0Wz9rGhyM09///5+pAbtctI2kJUca9cu+C4P4w=;
	b=RLnrdHotsXX87hEWjHyAJxLifduj5oLulLQba9sLSfC4jM5osrWr9cFJ3QvK/OZEizJE
	 WRVg6+PUW+MRKarmwhyuza67cSEevDsqgCzo1dI+j8m3VfpWzj19S/j9mKGQ99pSrDWpH
	 PBu5bikpISKYRvbwLo7bQvvK/lIFzW01CHWrLKgK7Sw+lIcuo4/PeNhbZfVIQxxCEfWwr
	 Z7xFj2l/KoFUDe661EKXKD3qV1zjUMbdDtqI6BgX3JK0X3pXlgaT4jb7g7CDlUEa5Xfzl
	 ASlqDZQaY1OhsWvrhR0vVhWfNOLPThMbkojoiDUegA1p74RxRo5LSWMJu1jrBXN93Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTgAYAyW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C57606A335;
	Fri, 27 Nov 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTgAYAyW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE111F00929;
	Fri, 27 Nov 2026 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795808760;
	bh=kcerf0Wz9rGhyM09///5+pAbtctI2kJUca9cu+C4P4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HTgAYAyW3IajlcDL8qw1eFE1wl5vm/PzjZDHxWlJjufp1QLj16mSEPhQK9WYrz9MF
	 rT0VJiqS0FOdTVTaVa88eay+IjxG08jhYC6tqhhDfB7DvaPrbXdavJRFsuvMvxNtFg
	 Yn1O2tBwXIMVeQeliX/2ygQAQIr50/F5La5TLMd9PPDN2GjEPsYKs/v7Pu/9hLnxhP
	 ntTZOU+KwsNEyO5EuOmYORVTXaDRsOI2LEqGH2JKd21PmoW/wD9zUo3/1PSVTepzEg
	 iNae8zT+l4JvwzYkjMfKp2GaalCHALsAcDUVuvD0vgTX/xZDMAyJ2Z1LbNCh4I+46A
	 cheTThDHMrtlg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 27 Nov 2026 19:45:40 +0000
Subject: [PATCH 1/4] coda: never point a file's f_mapping at a container's
 mapping
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
Message-Id: <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Rheinsberg <david@readahead.eu>, Hugh Dickins <hughd@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Alex Shi <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
 Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: codalist@coda.cs.cmu.edu, linux-mm@kvack.org, 
 Andrei Vagin <avagin@gmail.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4327; i=ljs@kernel.org;
 h=from:subject:message-id; bh=QVu7fb0kBPNVCyTuJn+VTrXPJuL+aUkLVFY1Ydjy6Xw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI577707/3+rru83v/RwiMc3hITPB3nRWid2nnsXnH9w
 0W1Lc+mdJSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiAr2MDO8r79aIsLUfPfH/
 eR1X/12eXR8kzL3Dayum+m5Xv/k6w4/hf5765ufqr64apv4sEH5wwutwRqu24qJWGZs3TAdqv+/
 8zQUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Coda file systems stack differently from other stacked file systems.

On mmap(), coda_file_mmap() switches both the Coda inode's i_mapping and
the Coda file's f_mapping for the mapping of the container file. This
causes two problems.

Firstly, the container file may not remain pinned, at which point this may
result in a dangling reference in coda_file->f_mapping, and so a
use-after-free in mmap() or lseek().

This can happen when you open the same inode across two files, mmap()'ing
in one, which assigns the i_mapping, and open()'ing another, which assigns
that i_mapping to the file's f_mapping, if the cache manager gave the two
files different containers. Each file pins only its own container.

Consider (A, B = separate open files of the same inode):

    A, with container C1            B, with container C2
    ====================            ====================
    mmap()
      coda_file_mmap()
        i_mapping = C1's mapping
                                    open()
                                      do_dentry_open()
                                        f_mapping = i_mapping
                                        coda_open()
                                          cfi_container = C2
    munmap()
    close()
      coda_release()
        i_mapping = &i_data
        fput(C1), the last one
                                    mmap()
                                      mmap_region()
                                        mapping_map_writable(f_mapping)

Secondly, mmap_region() takes a temporary i_mmap_writable count on
file->f_mapping ahead of the mmap hook, and drops it on file->f_mapping
afterwards. As the hook changes f_mapping in between, the count is dropped
on the container's mapping rather than on the mapping it was taken on:

    i_mmap_writable of                          Coda  container
    mmap_region()
      mapping_map_writable(file->f_mapping)       1       0
      __mmap_region()
        coda_file_mmap()
          coda_file->f_mapping = host_file->f_mapping
          vma->vm_file = get_file(host_file)
        vma_link_file()
          mapping_allow_writable()                1       1
      mapping_unmap_writable(file->f_mapping)     1       0
    munmap()
      mapping_unmap_writable()                    1      -1

The container's count is negative after munmap(), so the next shared
mapping of that Coda file, if it is open for writing, fails with -EPERM.

Fix both issues by no longer updating coda_file->f_mapping in
coda_file_mmap(), and by having coda_open() always assign the canonical
mapping of the inode, as do_dentry_open() may have propagated an i_mapping
which coda_file_mmap() redirected.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 4bb5f5d9395b ("mm: allow drivers to prevent new writable mappings")
Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
Cc: <stable@vger.kernel.org> # 5.3.x
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 fs/coda/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index c9fba41f7cea..64f05f2fc4b3 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -182,7 +182,6 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 
 	cii = ITOC(coda_inode);
 	spin_lock(&cii->c_lock);
-	coda_file->f_mapping = host_file->f_mapping;
 	if (coda_inode->i_mapping == &coda_inode->i_data)
 		coda_inode->i_mapping = host_inode->i_mapping;
 
@@ -248,6 +247,19 @@ int coda_open(struct inode *coda_inode, struct file *coda_file)
 
 	host_file->f_flags |= coda_file->f_flags & (O_APPEND | O_SYNC);
 
+	/*
+	 * On mmap coda_inode->i_mapping is updated to point at the mapping of
+	 * the mmap()'d file's container, and do_dentry_open() propagates that
+	 * to coda_file->f_mapping.
+	 *
+	 * However coda_file's container may differ, in which case the lifetime
+	 * of that mapping may not match that of coda_file.
+	 *
+	 * To avoid a dangling pointer, reassign the mapping to the canonical
+	 * one.
+	 */
+	coda_file->f_mapping = &coda_inode->i_data;
+
 	cfi->cfi_magic = CODA_MAGIC;
 	cfi->cfi_mapcount = 0;
 	cfi->cfi_container = host_file;

-- 
2.56.1

