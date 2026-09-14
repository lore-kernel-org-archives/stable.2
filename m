Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586136F8F7;
	Mon, 14 Sep 2026 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358474; cv=none; b=pvZgKYtT3oM86LTic8yWO85TdOmKZohUpGyyd7k2BTLXXRJP9dEQiTGHwKAbCWkhKbnNtvYlPFKkT+pM7eTmxtNed62d2yUlxRZLTHvtcijWBjbGyDFDLDnjGMT8cYHfcuwmt2jwf1ySO5VntUSooxgPgiwERZ7mcpF1iJMKDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358474; c=relaxed/simple;
	bh=hK0J/j6qYj3sBTYUIz1uCBElxeWALIV/ELJvCpQnyng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsLDq+MydcuLMj5CdjBauSuHOghvD4tNs/SXdrGEPHtmzJYxbSH16cYZX1cr3wIQv7N5A9m1nZ5IY9XXOV46+tSNgTP4J2bZqti9Z5lMEHCeMd59fn+hZJwhBvbfjNqcgmWzzX+qwwrIqtc4C4ygDZTVSGndGyPlGCeTsLSfla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=iRmnsczi; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iRmnsczi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=CexYb/ZPwOok20SRIWMS+o+yI4ZS21YJLiNyEURtSjg=; b=iRmnsczikDCsGPWPPQIAJwCrL7
	BgCKSqd7unCup3RXIk89tKiHwZDf8GJC9gML5MOd9Tj5cPxOd9tXzj0V+juIFtbW6YsKJVtqMkytR
	Ols9lsSo2JT9+x7enBuHgCWLeAefcRQHTDC4zdtRca2stQMT9LtJh9eVOTCVcOD7uD52mPb02KuCc
	hddVCgqqEE7DMFCVMooc6mpBeqssqppDM8qbTJSpjVZcB9rfiS2/w2ne08JpNIu79vDfIupzoYMsZ
	XwzSesw+1mhiZ6GTbxrIxT9rh6ljMF1jiExcLZxIvcIogX0WL4rgoaZ8YhizcsXFFOTTS4VSPeb8W
	iyuNYjeuWrCWccBu8kzcWXvdpKMaoNY2s+6KvIOFH9NWywhSEKH/X5Zj3NmuR5aeB5dJEITLESSnc
	AQtkDJ3rrbzISDNh4cT67DGeXO75brsOtxz/KJzYKj8KkIRW7uYrlXyVxF3YUXmI6GAGMw8Mpxoql
	Wx2Ewz98pw5is8iN+1HfdYkslW6FZ0uPaa4LZ8KJNvhlJepxCBPY80WinVf/OrR0Mj6bH22U/SjeD
	0gupP47rDGtkg5GRpot7ZAjEJNRo7dGUOgYGRi8Ee5GUgfMGmzaLx4gRH1uVf6noIbE82sKRL6ZvU
	fILQpXZ2EvJ5MsnYA8KJFST8PqUW+5aBHRh8N1JQQ=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
 Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
 Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] 9p/trans_virtio: bound RERROR copy by mapped pages
Date: Mon, 14 Sep 2026 06:01:04 +0200
Message-ID: <25205411.ouqheUzb2q@weasel>
In-Reply-To: <aqczkXDT-thZshJr@codewreck.org>
References:
 <20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn>
 <23241140.EfDdHjke4D@weasel> <aqczkXDT-thZshJr@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 14 September 2026 01:36:49 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Sun, Sep 13, 2026 at 08:09:05PM +0200:
> > > I'm not sure that can actually happen:
> > > If there was an "in page" (if there wasn't this is all noop anyway and
> > > data was written directly to req->rc.sdata), then req->rc.size amount of
> > > data was received into the pages, so if it does happen to span over a
> > > page boundary then there are at least two pages and we don't need to
> > > double-check here.
> > > 
> > > Christian, do you agree with me this patch is not required?
> > 
> > req->rc.size is coming from virtio device's used-ring len, and that is
> > written by 9p server, and this server-written value is not verified
> > anywhere against the real sizes of the descriptors that guest provided,
> > neither by the kernel's virtio subsystem, nor by 9p client.
> 
> Wait, is it?
> req->rc.size is written in req_done() and comes from
> virtqueue_get_buf(), I assume that was the actual data obtained from the
> transport (e.g. akin to read() return value, not what is in the payload)
> Or can the server lie about this?

net/9p/trans_virtio.c:

static void req_done(struct virtqueue *vq)
{
    ...
    unsigned int len;
    struct p9_req_t *req;
    ...
    while ((req = virtqueue_get_buf(chan->vq, &len)) != NULL) {
    ...
        if (len) {
	req->rc.size = len;
	p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
        }
        ...
    }
    ...
}

drivers/virtio/virtio_ring.c:

virtqueue_get_buf() ->
    virtqueue_get_buf_ctx() ->
        VIRTQUEUE_CALL() ->
            // for "split" ring type :
            virtqueue_get_buf_ctx_split(
                vring_virtqueue *vq,
                unsigned int *len,
                void **ctx)
            {
                ...
                *len = vring_read_split_used_len(vq, last_used);
                ...
            }

static inline u32 vring_read_split_used_len(const struct vring_virtqueue *vq,
                                            u16 idx)
{
    return virtio32_to_cpu(vq->vq.vdev,
                           READ_ONCE(vq->split.vring.used->ring[idx].len));
}

And `len` field is just shared DMA memory written by server. The len value is 
not questioned anywhere in the call stack, it is taken as-is.

This is for "split" ring type which QEMU's 9p virtio device is always using 
(as QEMU's virtio device is not advertising "packed" ring type). Linux 9p 
client is agnostic about the two, but it does not matter either way, because 
even with "packed" ring type the call stack would be slightly different, the 
len field would be 32-bit instead of 16-bit, but its value was still not 
questioned anywhere.

> If we can't trust req->rc.size I believe the p9pdu processing will also
> read past the end of buffer so there are much bigger "problems"
> 
> With that said, I agree with your assessment that qemu is mostly
> trusted, and don't want to spend too much effort on this (unless
> something like me losing my job happens and I suddently find a lot of
> free time :P), so if you (or someone) can confirm rc.size isn't trusted
> then let's drop this here.

Surprisingly though, it is not as bad as one might think first. OOB should be 
limited to the page walk in handle_rerror() - this patch; and to pdu parse for 
the 9p2000.u error string (i.e. Twrite ZC -> handle_rerror() returns early on
!pages -> p9_check_errors() then OOB there at:

  ...
  p9pdu_readf(&req->rc, c->proto_version, "s?d", &ename, &ecode);
  ...

All others should be fine actually, since:

- Non zero-copy 9p request types are safe (checked against capacity), so it 
boils down to Tread/Treaddir/Twrite request types responses as only possible 
cases:

- Tread/Treaddir/Twrite returning *non-error* response (and server lying about 
len): all count validated by client already -> safe.

- So it is really just 9p2000.u Rerror returned for either Tread/Treaddir/
Twrite: Tread and Treaddir handled by patch -> then safe, Twrite as outlined 
above being the only open candidate left and that could (additional to this 
patch) be easily fixed by just moving the P9_ZC_HDR_SZ clamp before the return 
on !pages in handle_rerror() happens.

Or:

You could simply pass the bad card on to the virtio subsystem maintainers, and 
tell them to clamp used-ring element's `len` field against the guest provided 
descriptor length, then req->rc.size would be trusted - no validation to be 
done on 9p side. But even then I can imagine that this would be implemented by 
virtio maintainers as an opt-in solution for drivers like "please clamp this 
for me" to avoid breaking certain legacy devices.

> FWIW I said "mostly trusted" because lately we've had things like black
> box hypervisors (I don't remember the exact name) where guest VMs memory
> is encrypted and can't be accessed even by the host: sure the server
> could still *crash* a guest, but it shouldn't be able to get arbitrary
> write/read primitives, so if someone wants to spend effort fixing such
> bugs I think it's welcome and I'll be happy to take patches.

"Confidential Guest Support" is the term. Wouldn't change the picture here 
though, as this is about a host triggered DoS. Host could still kill the guest 
at any time.

> > P.S. Remarkable backlog processing today! :)
> 
> Thanks! I _think_ I got to at reply to each mail I wanted to look at
> overnight, but I'm sure I missed some, so if you have something in
> progress that you want me to look at feel free to ping me again
> (and someday we'll be able to get through the virtio backend page
> mapping rework started in December[1] (Christoph Hellwig didn't forget and
> pinged us in May...) / your msize limit lifting work[2]... someday...
> But that should probably get priority over chasing untrusted servers)
> (The links are for myself more than anything else, my working memo is in
> flight mails)

The negative dentries patches come to my mind which you might have forgotten; 
I think v7 is the latest one on these:

https://lore.kernel.org/all/cover.1779355927.git.repk@triplefau.lt/

/Christian



