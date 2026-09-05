Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1C3546D8
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570431; cv=pass; b=nFnv8ESpM/ZtBczUAhz6khsvcEvDlz53ZIBz1MXGtJBfG1yT2gFesnNvIIdNT7m/9p/3E3DRbo5XrmB4zsxzFeeM2B27/9cO9AZYpBfZkY7JEpflmOnLZ8bYoYHyQAHZyPuTPud9Z2+wjyFU8VRqOW0GsB3lTwSwbqKrtKQVr70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570431; c=relaxed/simple;
	bh=l4lbMsjzHIBKAWcJH3OSXGknOIWY0eqTpDnrL5yI+6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA8XOzXlHF2MtQ82GfUwv9N47DRoSfWoGAypi2GkSHp3XACihccxDxBpVAqm0ySLiTRDffpRuzXmzpUhHZQCy2upZ5GpNk9Rr0kASYpYlPjy9FbsdpCkocVvwd3XXmPMcuX4cuiJBk2jQ2doH0H7NvFvKi8zY9RSenYb8xR++rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=I3SRZnCq; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="I3SRZnCq"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso217619266b.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 18:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788570426; cv=none;
        d=google.com; s=arc-20260327;
        b=D2YGFeFmUegT0nZMbe/cH/6djcKo/wuRFq6lFfB/eYAO0qFTN1gFLaoVj5eRJnGYaw
         /vzBIJN7ctvXm/5Vp99uNJD37zxoX7uTz4adOONNmg1VJhtTPQpGETTJ1CViUNGQFoov
         40LwBMRWSGC83e2TOT1zP6YAnR9k/UkMGt2Uqhspxtnkhso4nislUAUlwZ71Wt8aIbSD
         t/pLjzsE9lzB6EvIT5add8I4zoDqKfJPX3MtKi6f8Y54YRblwe4QVnFdvTaOXvQ/qowt
         2ZBi2gP6CsdY3JfFOUjyuxNYNKZYF4zXkQzdqS7JLWMNhhW0gPnyeOLR2c5H4uG4w+rZ
         qzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ujZhsoHbAO3klq3jT6TYLR85CcPWbD1QdBubluWqS2k=;
        fh=oBw8Hls3ZHH/WSHBOz9zjaG0U9UnwASUZM4gAvxvgP0=;
        b=fKCOkdHaFqqQlNGXMfANzvQSuEl0QBvVqd2Zx9XgowO9brnM5yn338hjSc6V3f4XaP
         BixZmxqJ9gEqERcr5s5INZ6ufufJ1IDv5GjerydZ/8XrTzIMcai2SN6va0lppWILF7AA
         nkNTIqxA5jLLbaxD6Y/XWjP8di71OA/s9+P42yNI0m7n6QATersE6/U9/fn9Su//t9yA
         dk9ETASoplVurJBsuXhcR8zebCb/1heS+tSvyyvxWmkxzSmIgibfTIAVKZ/TsaakzS/Z
         XPEN2wFx4jgV7tQMacLb1R/i/dxJfCqr2oYReg7JafZM8EQNq7dr77Ts3xWFpBTbd1gK
         zcXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788570426; x=1789175226; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujZhsoHbAO3klq3jT6TYLR85CcPWbD1QdBubluWqS2k=;
        b=I3SRZnCqj7a26Bkwzp6neRlL5ALP/ngHtU4QDSvu2XnTsb9SQSoDQ7IDiJcvjcjcj1
         TrFheJrwWJstipHqQv+qWutaWFUBS1B8iSGm0X/ARyICFXnfcLQDmMyZu3SmN8EmhaR6
         0FLNEaojSXX1cXMeSXf306ghyA05WOEdElHNi2MA/vHtEJCTMIE1Ye370iNgPo3wKLM4
         T4pJIOQsbkOqGbNzN9FDr632ajUDBYlgcKs+2S5c/pwVPCbUYjrSdx+7DsHXVnbhOSnE
         FTkUvF6jegjvHyLI+U+bgJBEF3y9ETQPHqstTnk4m8HwGrVpgdPlnCFuQVRD2fR9XLFc
         OfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788570426; x=1789175226;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ujZhsoHbAO3klq3jT6TYLR85CcPWbD1QdBubluWqS2k=;
        b=EpikYTxsH8lJaOmDxLpVxafGmP4X37A+UBV0AIlracQ/Mc8hGrsCsakU5pNv+1E/OV
         Skn8huyiMKWS2SqLi3zG9gbXFmvg1wVldlIvzh5D7qi4CwpVFwKOlKRFZE9yv4+bKg5w
         YS7xLlKvKq+OD7jp2+mqNpT8JxKUcZ6Incey+ReqQKBpFO4sdzX/dK5MpTUSZATig8LY
         XqGqjXMLldqSHIkaSpH6a6aOfnzBwHdjSn2ZwDJdHUYeX5BzZ8QyC2Rwct3Qdbu/KF7w
         FNNeoa9zDnxt43v0FW1WRqY5CEgqxDlYpZLWTMNymuffZiLbRCmU6YpKeRkEF9qDcyDZ
         0pTA==
X-Forwarded-Encrypted: i=1; AKwUvBzZlRV1YRCWrFq5hAoenEgitAVUucV1RKxOgg5mqTyJpV2CO0YmwRTbuqHSS6upY4nhvLswqgs=@vger.kernel.org
X-Gm-Message-State: AFuF++ntHtskdYZXgA/vUTkGDDPZuWH/ntPWrzUKTRQtyvqQwVjYoX+A
	2/mTo65+FxxugP3tdEn/9pZQOTp+hDJ5z4RHtDy0yLFzoT98OgkliZy0lYVA5gWpkLYg09JL/sB
	SQdT8XdiGsVWmTY58OoBk0/19KFsuhLkxPDILbPeK2A==
X-Gm-Gg: AYBFou24t8kSrN04udbx3Z8CNrQs/T4HCmkJB1suMY9eaXDxcJOYUOz16Fzt1c5AcCs
	BwShngiCn+tm0GYnrbacC8ukXPKcqm055G+QsRfRPGaCjAFhq/F5/cidwp94m+sB+/J7SPDra0+
	FcpvWsSoPJ9d0PP5WOyHSYeAthkvKxgxHSWyB5jy/H0A9TRHWMDIsnM+uxwEbl1Jx+5sIBK5Bf6
	OCy1UTKC+o1WVMdDUx8UTzTeXIG+JnaXMHWaiRi1qMi/GdRpRvYYPenDEPAcCYv182155SZ9nRE
	M2rDdKHLp1yx8S9iDl/ytsENqPWqQQPGP4NVjmZbkIlj0g==
X-Received: by 2002:a17:906:ba84:b0:c20:f871:1020 with SMTP id
 a640c23a62f3a-c260ca1a225mr418338466b.19.1788570426412; Fri, 04 Sep 2026
 18:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904105122.19938-1-max.kellermann@ionos.com>
In-Reply-To: <20260904105122.19938-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:06:54 -0700
X-Gm-Features: AcwNN1WmSnQ67Mot0ciiOWGEftQEhKrd_OJ6L1dPrjt_nxXJMF9e7T3Gb23qprw
Message-ID: <CAOJNxRKD73gsja26b3iidhBhAW=Buw3rHmttBVU3wzg0uyAhsw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: acquire caps for read_folio without an rw context
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 03:51, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> This fixes a data corruption problem that leaked permanently into
> fscache.  File-backed erofs reads metadata using
> read_mapping_folio(), and the Ceph implementation of this call forgets
> to acquire Ceph caps.  Therefore, mounting an erofs image file from a
> Ceph mount that was just written (but not yet committed to the OSD)
> would fail because the erofs code saw only zero-filled pages.  These
> zero-filled pages were then copied to the fscache, making this data
> corruption permanent (on this host).
>
> Usually, Ceph checks/acquires caps at its own entry points and not in
> the `address_space_operations`: ceph_read_iter() and
> ceph_filemap_fault() acquire Fr/Fc before calling filemap_read() or
> filemap_fault(), and ceph_write_iter() holds Fw/Fb around write_begin.
>
> Only readahead, which the VM can invoke without passing through a Ceph
> entry point, checks caps itself.  That check was added by
> commit 2b1ac852eb67 ("ceph: try getting buffer capability for
> readahead/fadvise") to the readpages path, converted to use the rw
> context list by commit 5d988308283e ("ceph: track read contexts in
> ceph_file_info"), and moved into ceph_init_request() for
> NETFS_READAHEAD by commit a5c9dc445139 ("ceph: Make
> ceph_init_request() check caps on readahead").
>
> The single-folio read path never had such a check, neither in the old
> ceph_readpage() nor in netfs_read_folio() via ceph_init_request().  It
> assumes that the `read_folio` method is only ever reached from
> filemap_read() or filemap_fault(), both of which Ceph wraps.
>
> However, since Linux 6.12, erofs file-backed mounts
> (commit ce63cb62d794 ("erofs: support unencoded inodes for fileio"))
> read all metadata (including the superblock) by calling
> read_mapping_folio() directly on the backing file's mapping.  On Ceph,
> this issues an OSD read without holding any caps.
>
> The result is silent data corruption.  Ceph clients do not write back
> dirty pages on close(); a writer keeps Fb and its dirty data until the
> MDS revokes the cap.  When another client opens the file, the MDS
> initiates that revoke and replies to the open immediately.  A read()
> would now block in ceph_get_caps() until the writer has flushed and
> acked the cap-revoke, but the erofs superblock read goes to the OSD
> without acquiring caps and thus races with the writeback.  If the
> object does not exist yet, the OSD returns -ENOENT, which
> finish_netfs_read() treats as "success, no data", and netfs zero-fills
> the folio.  The folio is marked uptodate and, because it counts as
> downloaded from the server, is also copied into fscache.  This never
> recovers because Ceph invalidates the page cache and fscache only when
> Fc is revoked, but gaining Fc later will not invalidate it.
>
> Add a Ceph read_folio wrapper which acquires caps synchronously when no
> rw context is present.  Cap acquisition can process a pending truncate,
> so drop the folio lock before acquiring caps.  After relocking, verify
> that the folio still belongs to the mapping and has not already become
> uptodate before passing it to netfs_read_folio().  Leave reads with an
> existing rw context and the legacy inline-data path unchanged.
>
> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note:
> - commit e587a984d332 ("erofs: use dedicated meta inodes for
>   file-backed mounts") eliminates this trigger, so Linux 7.3-rc1 and
>   later are not affected.  The fix remains relevant to older stable
>   kernels and to future direct read_mapping_folio() callers.
> v1 -> v2:
> - Move cap acquisition from ceph_init_request() into a read_folio
>   wrapper, leaving the readahead path unchanged.
> - Drop the folio lock around blocking cap acquisition, then relock and
>   revalidate the folio to avoid a truncate deadlock.
> - Preserve the legacy inline-data path.
> - Handle a NULL file argument without acquiring caps a second time.
> - Require Fc before populating the page cache; CEPH_CAP_FILE_LAZYIO
>   cannot be added because the want mask is conjunctive
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/addr.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 657c2cb0f881..78b805ccc5d4 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1959,8 +1959,64 @@ static int ceph_write_end(const struct kiocb *iocb,
>         return copied;
>  }
>
> +static int ceph_read_folio(struct file *file, struct folio *folio)
> +{
> +       struct inode *inode = folio_inode(folio);
> +       struct ceph_inode_info *ci = ceph_inode(inode);
> +       struct ceph_file_info *fi = file ? file->private_data : NULL;
> +       int got = 0;
> +       int ret;
> +
> +       /*
> +        * Existing Ceph read paths acquire caps before entering the page
> +        * cache.  Keep the legacy inline-data path unchanged.
> +        */
> +       if (ceph_has_inline_data(ci) ||
> +           (fi && ceph_find_rw_context(fi)))
> +               return netfs_read_folio(file, folio);
> +
> +       /*
> +        * Cap acquisition can process a pending truncate, which may lock and
> +        * remove this folio.  It must therefore happen without the folio lock.
> +        */
> +       folio_unlock(folio);
> +       ret = __ceph_get_caps(inode, fi, CEPH_CAP_FILE_RD,
> +                             CEPH_CAP_FILE_CACHE, -1, &got);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (!(got & CEPH_CAP_FILE_CACHE)) {
> +               ret = -EACCES;
> +               goto out;
> +       }
> +
> +       folio_lock(folio);
> +
> +       /*
> +        * After re-locking, check if the folio still belongs to the
> +        * mapping...
> +        */
> +       if (folio->mapping != inode->i_mapping) {
> +               folio_unlock(folio);
> +               ret = AOP_TRUNCATED_PAGE;
> +               goto out;
> +       }
> +
> +       /* .. or has been filled already meanwhile */
> +       if (folio_test_uptodate(folio)) {
> +               folio_unlock(folio);
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       ret = netfs_read_folio(file, folio);
> +out:
> +       ceph_put_cap_refs(ci, got);
> +       return ret;
> +}
> +
>  const struct address_space_operations ceph_aops = {
> -       .read_folio = netfs_read_folio,
> +       .read_folio = ceph_read_folio,
>         .readahead = netfs_readahead,
>         .writepages = ceph_writepages_start,
>         .write_begin = ceph_write_begin,
> --
> 2.47.3
>
