Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3B5476F2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082834; cv=none; b=FrPh3fThT5mzkXlZa44c+twJ0NiUmj8vcNcOJRwjAmMAYatR+jSOAPAqLT4V87ueU0K6FQJ3RWnTKIlHxlp9CuYU9Vq4SpAxPi5XOov0ENw9Db5l4bz03u74jdyGT0nt5UilDlY0oW7T/kvM3clIvFVr5gp206TPUiQ8DwXez34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082834; c=relaxed/simple;
	bh=oOui4zK6FIe70bxPh3uf6x1iuyJg4jcWicCOXddxrNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHM3Gbk4EKWhWfOaIqIBckCToCmEY60HRNWJgP8wYDU9SRDC5D57t9tV4/9vqfzPeIyM0GYC4Gve8yoBpCtqmNYAJb9RhyYAYHP43WXRTa82bskLQWvb7p890fbquaV0j3fn/vxRmwrdh21ywq8/v7moc5iJ1yPRT3WC1snZA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjH/QJ8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjH/QJ8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E31F00A0F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082832;
	bh=oOui4zK6FIe70bxPh3uf6x1iuyJg4jcWicCOXddxrNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PjH/QJ8hvA0sOl2Dpfs8o9nh3ZPYx/skwjWu6d+Lm0WirmbyAFPVzv3IqYUUEoVsV
	 rnkr5IPkYjwet47lyZR62BE4UDJstR+kHrWs2IM0IwrENJJd1WsXYFA+4Wew743eui
	 mQkFvGLz4awouErA26ETfEZbzyS5gC9BqfskAR7D1Iernc7qbiirkSNiZ4RtjvI+VC
	 DDNVV12LLIXURBAzFaKK5+1Jvf++r/vR9YMUBmVHo5sOPXEBhukRf+tlxw6wyL2AQt
	 cUC6XMW1gmTthUjE1BcG7Ii/IP3/c0wmTAKOhG2vJM6XHYfgDetPWLT4DccRMzUiUV
	 cNGf/1KuAQfsA==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98dfb8002so5824634a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:13:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJ0CG5OU8P/NScZkRflBPR3ZIudG8FasjJFRLhmqpqY2wWJf2/jIEjOUD9601xHz4plJYZgog=@vger.kernel.org
X-Gm-Message-State: AFuF++kR8zkgwjuib3UhiAQ1o91MSuehjMVdm28UPBSHqPcpKv4y/0Rq
	TMGbsRc6bp7cg2n1LfcbZREZBU/7KJ9O9txmPqeVA+s5bpJfLYygVHIeXx2T5lZMxoJG1CybHAp
	3bnjljHPD5U3VsWxyBbHH4zvunra5Ayw=
X-Received: by 2002:a05:6402:a509:10b0:6aa:96b3:9d7b with SMTP id
 4fb4d7f45d1cf-6aa96b39e75mr2793518a12.45.1790082831228; Tue, 22 Sep 2026
 06:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922043301.15101-1-kmehltretter@gmail.com>
In-Reply-To: <20260922043301.15101-1-kmehltretter@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 22 Sep 2026 22:13:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_3w_pjF9Y4H97UrCQ5Q6wYtCmfbiFBYa4t+5HkcJOYJQ@mail.gmail.com>
X-Gm-Features: AclHuK8pziMClaJLRmRE5rz8-0BWbIB6CDlKWZzsGG_dIfU-CEW00nSs6TQpmGs
Message-ID: <CAKYAXd_3w_pjF9Y4H97UrCQ5Q6wYtCmfbiFBYa4t+5HkcJOYJQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: include the final partial cluster in sync writes
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> ntfs_attrlist_repack() synchronously writes the replacement attribute
> list before updating its mapping pairs and freeing the old run. With
> 512-byte clusters, a 544-byte list submits a 512-byte bio, but the
> write returns 544 and repack accepts it as complete. If the later
> buffered update does not reach disk, the replacement list lacks its
> final 32 bytes.
>
> __ntfs_inode_non_resident_attr_pwrite() converts attr_len to clusters
> with ntfs_bytes_to_cluster(), which rounds down. Before repack, its
> synchronous callers used either cluster-aligned lengths or lengths
> smaller than one cluster, where max_t() selects one.
>
> Round attr_len up so repack writes the final partial cluster before
> publishing the new mapping pairs.
>
> Fixes: b1d732e62a5b ("ntfs: repack $MFT/$ATTRIBUTE LIST")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Applied it to #ntfs-next.
Thanks!
