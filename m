Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2763560AB3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962223; cv=none; b=kDm9kYzaJ1EsqySSP8G2290/nudYmcvpNI4w2DxuJWgHuUcJkGWUeaN0vJS+ua2yz+IFzsNRIUnjEoJSgXWOJyZ/q3njLXHc8/uCZejTaxrgJ2l7ZzWddwKyvVPB+/gvtphMYVJ1gnHE4CHaf3+rfHyw4iy9P0EDdeKtPAhk6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962223; c=relaxed/simple;
	bh=OG66/W9xP/T+E5n8aa6wxhobUDvh4QNzT0djep+/BeM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ueIw9Nl3w/wnyOeAMz/34Geo2GJg13fW8pqrK0q/r0JpSw/G2AX13Vvng0hRgYa4/vx9sq7AK4iW8jtqA80DkuCOlL9TLgI9dqsS34jyFSN0roMs+f+I+nac5HqO0b6qv1HRfWAWnK26pJIxDJf0mZurfxm8mrUvKZKdXwkGiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sSSsP74D; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sSSsP74D"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4e729368fso5067980a34.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1788962218; x=1789567018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Izff34GpIlMgrbcmpOUE6ehHq98Xxkap9RJGHMjnE1U=;
        b=sSSsP74DYnZ9nXz7/VQXgbqPOZxb0bdlGKW0Sg9oTXNgtVVMTa6kKMYqzZAoI7xvk7
         JJetQgeLn140AvfndH7V5l596CSARV4mclS4dypDH2nnJWAyvJZpaGpb35lX3m/oiJwI
         F3Otv4nbdZ9jbrdsKjPvGhFcShRS/IJoPJgbTOl9wt6I/BC//74WEo+REdTN43+GxUL0
         Okl3dEon9Day4vKr5GQa42l7ckcJpZQOeRE+o+oNu08FTnHvFY3beU6EQFReXZFAPnun
         eznS7gauiNt6gTyk0Zt/oNFbJfF7nGNvo4IEb5gSrVF25E5lWgNqjIIGRhcSkoymMcP/
         osLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962218; x=1789567018;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Izff34GpIlMgrbcmpOUE6ehHq98Xxkap9RJGHMjnE1U=;
        b=huen9M1BuWItafSeQB7hz6BQXAU+rYHNaRFkgfn6ZWIEnYr6DF51jBE5Ekr43eRq15
         te9VxoD8F1pGa0b9RzBPp6cv35KjNXhwuOMzCB3HNu7Nt7Hg2F16o39803US12EDnfmB
         BXfHLPiWI5mRB1YIb2nHricUHFqbWaUA7KXQGQk+ZxdlkAWefkQ9swSZZVat1QUQmx/B
         5ckx0VrraDBSGYJb5E7uasukazQOqoQwMcZiRv0F/bJ7uE/m08PfOJNa0WmpQKk9t4pu
         1hkseQoEinBwvPzqd5w5/k4AQYlfbmn0McT6efXuLqplfQC6pz6QgbUIOIPotILZddak
         wK1Q==
X-Forwarded-Encrypted: i=1; AKwUvBx897HyPY/l6wpqx8ux9vO93/6hslgZzsOVoyej+Qj4ShhxvxZa5jtP+11PnP21ZRcdrzz/aZI=@vger.kernel.org
X-Gm-Message-State: AFuF++nP/N24/c/NkHfkt/2Olxq4sqevJ1dcUYPZ7x10ghUpEraIfuKw
	kad/Fn+REY/QWH6Pjfpvz6Ej00/1ZOoBl53Hx0Y/0c7g9WG6ipQSIeR4p2FtGF/AUC7elBxhq7Q
	SOMLoFCM=
X-Gm-Gg: AYBFou0oq4335PErbVwdv2TJyGhu+DJvWTmab8xTusAydVm7wrpeksQTwMksSMhsXBY
	lt1UPG41qT3oBctYG9YLDMeOBOfhk4Wxh8RUQ/PQ3tip+w/nvjN2bBFAy+sVfaQlEuRtNyfKYUL
	0W9lPDjWmr9SCiauzGD97hOf+erzmv2jOuXkCP5b4s92P+J7JwItMvwt11zboEww1hVqKzuWHJX
	KGZvGyqpbU3MjwMPSUXs2gUjy66EhBIuvJw1xvvKdPdyPlBHWOv2pltORUIyN9Fv+1wmAsAi3KO
	Hy30d2B7rYSj/NeyizIpCBg1gJC4qotoUSd5vaqf+eT+87iiVMMxX8I90M202vpcvMCMJgvmAC4
	nmF19oRWT70C0z55AA6O8UPpsQ27miCLdNc6uFd8eIYEkItJpDoGlP9qsnzr7mz+4YEr4va3+i4
	r8Z/GqmAJSUaddnrtVrALrE1JPNe8OA1LRv1GmiS8QX0rQA93Zt+ZQD3gD1kBDdjJXWvgE47KH0
	Bjhj/p2DRdF9Zz3QhsI0bOBxSpqv6MIInkhcg0nYWRIaHDXuCDmx441cQ==
X-Received: by 2002:a05:6830:64cc:b0:7fa:ac4f:78a with SMTP id 46e09a7af769-7faac4f0e55mr16975714a34.22.1788962218501;
        Wed, 09 Sep 2026 06:56:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6794e6fsm17725097a34.9.2026.09.09.06.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 06:56:57 -0700 (PDT)
Message-ID: <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
Date: Wed, 9 Sep 2026 07:56:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] io_uring/net: don't overconsume buffers when using
 MSG_TRUNC
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>,
 stable@vger.kernel.org
References: <20260902230041.1320658-1-krisman@suse.de>
 <20260902230041.1320658-3-krisman@suse.de>
Content-Language: en-US
In-Reply-To: <20260902230041.1320658-3-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> When a recv/recvmsg is issued with MSG_TRUNC and the incoming packet is
> larger than the provided buffer, the net layer returns the full length
> of the packet rather than the number of bytes actually copied into the
> buffer.  As a result, io_uring advances more of the provided buffer ring
> than was actually filled.  Use the actual filled region size to consume
> the buffer, but still return the full size to preserve MSG_TRUNC
> semantics.
>
> Take care with multishot, because that seems to already truncate the
> consumption based on the available payload size.
>
> This was reported in https://github.com/axboe/liburing/issues/1619.
>
> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260728191454.1850326-1-krisman@suse.de
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  io_uring/net.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/io_uring/net.c b/io_uring/net.c
> index 647156c9331a..f8110dc9f860 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  static inline bool io_recv_finish(struct io_kiocb *req,
>                                   struct io_async_msghdr *kmsg,
>                                   struct io_br_sel *sel, bool mshot_finished,
> -                                 unsigned issue_flags)
> +                                 unsigned issue_flags, size_t consumed)
>  {

Not sure this is correct. If consumed is a size_t, then the comparison
between ret > len is an unsigned comparison, and every error will then
get clamped?

Will need something like this folded in.

diff --git a/io_uring/net.c b/io_uring/net.c
index f8110dc9f860..0ca43a24f1a5 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static inline bool io_recv_finish(struct io_kiocb *req,
 				  struct io_async_msghdr *kmsg,
 				  struct io_br_sel *sel, bool mshot_finished,
-				  unsigned issue_flags, size_t consumed)
+				  unsigned issue_flags, int consumed)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	unsigned int cflags = 0;
@@ -1027,7 +1027,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished = true;
-	size_t len, consumed = 0;
+	int consumed = 0;
+	size_t len;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1080,8 +1081,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		 * buffer.
 		 */
 		consumed = ret;
-		if (ret > len)
-			consumed = len;
+		if (ret > 0)
+			consumed = min_t(size_t, ret, len);
 	}
 
 	if (ret < min_ret) {
@@ -1195,10 +1196,11 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_br_sel sel;
 	struct socket *sock;
 	unsigned flags;
-	int ret, min_ret = 0;
-	size_t consumed = 0, len = 0;
+	int ret, min_ret = 0, consumed = 0;
+	int consumed = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	bool mshot_finished;
+	size_t len = 0;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
@@ -1273,8 +1275,8 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	 * buffer.
 	 */
 	consumed = ret;
-	if (ret > len)
-		consumed = len;
+	if (ret > 0)
+		consumed = min_t(size_t, ret, len);
 
 	if (ret > 0)
 		ret += sr->done_io;

-- 
Jens Axboe

