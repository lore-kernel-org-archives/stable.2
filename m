Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358315;
	b=anVn7f35uLMLtVwLU+wpkVQf70hjCoQD6mwWfS0OcYQlbaox5iVtzGrWTEb6aDS/W98K
	 UEqMdfmnJQOKs2mvBw+9gUbKK+VMCNj5u55dTGTGZK7mZ8+v2yeCA9NGfnW8huooQpTqg
	 VV5ZmiAc4YwM/xp+go3Eh3XjG+QaQ9N0ZjKzPp12fB8W3SfzKL5W+ZC6p2tUFwGJ0aOOa
	 RvYHyMqjN91kUsmb32ms/M6fQQLCFDgw8DRLkzMIzIRglVU7XhbBOIYMJi1/wqZrJVoxh
	 lB11SV9jSwNp7mHSM+DOsTvkhzVHzgpMf0bbOCkoNqTQ50D4dfrxYZRK2Ub0tYyzb1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
	b=xSmaTke9JFk29ZoUBysRmuDrEMfrfAMHwMj0C/5+N7HZbKItn7o6ypWKZoTK1wqK9wRv
	 W2+QjUAg8yR4k3WEl4LsTe5FjT0fiW17iFUtNNO4b57jHPmouU20V4iGQFl3S/LF9Wy0s
	 xc2KRlwA1rq6uDE8ZvSdMbvdx9++UGZOWRl0cM8CgByCXfDMVlScFVxxa0mcdrRlZxCVp
	 1hHxHWmhRJZonCEfNKS7/oniMzSZmZDK6tqjfxof3NGlwZPEeayCVTOMEyBRtAXkuKKlv
	 FGQnlLNVSCUPerxQObhPh8NC0dqUW7FqRA2xrC5u1LD2rVGck46TiCzBwy0xt7ipWfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AfkFgl4A;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D24606A336
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 14:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D24606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=AfkFgl4A
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-92123f02faeso25363186d6.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795358314; x=1795963114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=AfkFgl4AHUA11Cz2zk8WBBwMK+X/HIDzRK5+MYdyi2ng/C7wpuCEEaLWnoeurwqvhc
         un8Y9P/KDffzAn5QBJDeL95Aonms5uE7VqyjYxlDXnsQ9+vnFoScbxVFG7Dr/LMkHOCp
         YipueMC5yBS8tK17Sc3TAIfKjE6glUoTJx3lJbFarCR4x9CstDkU6KBjnKZ5ECcdXJd7
         rfX77s4AmQcKf+/3t7duDnQDJEudfPbSV1EUFq5u7GTJj3K8Hfuoq2MM5UZFPpsvLmsS
         z8Eiy9QQJzDIkaBR72BN3SlcRBurKtzYxdgpoEgVrs17Nz+Iy/+xd8YUONSHPtLaM/3i
         QTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358314; x=1795963114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+lBzUtZbcPnxrRlj2a5ONA5sbQ6rA0NyyUMApXQnAc=;
        b=2SB8pv8qySDQG23+Pj34cLSIjDodTrKjN/nQnVQ0+qXpKthyNjmBpHSS86Mj/ghGd4
         cn3BijHRmEuewIX+KuEeQjeu1ULn5VAY/4O7hfe1nCwl3rf99E4k2BnvpzlPh3/ypw65
         9vABDhunVeWNOv0swSUx0bxRSjqSzDBY0CPjs2dz0m3xlylRk0Kc3sbTycO21yFkOdlo
         YzydkgYxSQqMbUIUG/VoZdIQHarIMgxHJyajKf99x3lO5/+4Aik3CpGO60umn1oSJ8wf
         ms1MvHZn+0XkFCNsDKBWYwN8BJxcq2TeaJMqzhfIRiByBDiwa3L7cGZL5mAjT1y/EH+D
         KMEQ==
X-Forwarded-Encrypted: i=1; AL+hErEtHyoHs4D1buQ8rS5GtM/6kU2am8sTNxKK5c7EkutFGHwof7AdlGkWvO/3rYRrOJ/iBaWCCHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I0yDCdBv2dJrmHGoWeiHH2RhdRUzeEAe6c5hPxYUZiL8G2cZm
	zklwJ3Kf9fx0C5mysGmv/EHjpVPiuBW1x1EomPgInoyZiM5y6aDyMtWEdT6H8CtHLg==
X-Gm-Gg: AZFdTZf7TkFofX3iSC+uNfXECSgTum3P+MSKNdwnfWBuP2pUpHj+IZpy05NvdpoSLHl
	+SclzAB3e/ah+NsAozRhK0XxCEuZjPfpErfQJM8XNEZy4tYD4XgSQCA9GXcSnwo9n1dUGUYCKX0
	yN7HAV1vDoYA3Rqo1fs0y8SQqWmuhYH0etw0xpmFd6Zka4niaglAA5vAOCU1NhNHAH+3qYw/P7I
	K122GmbDHZwzZc7roJnXo90u+BBlfe8C3BiZqQQZ/o39/5QvNtkTmhebY3rc54axFC0sUtjPhLO
	lkYXkA/Pk11Hi8KZeuXsfxwvlwVqztteWvYYz+PA6rOd+o4POpQN7nWyWJcG9tTvE1E8jvDb4U5
	MiCGdW2mola7c702g4+iA3djCA9QD5XLCAZbbbN3ioCPuF5LXnWV1wjXpIBLGwGETTprxcavNK0
	JMWzjF2Z6PY6RFonPix+PxNtHcMG0Y3jGxHLB+BzPRJUvKuGRqryINq2x//o5ILWc0Xb6/OaqNN
	dyYwjF3h1a8yfiGt4m9/czZY9JY6wgO63yFQ1WD0kgZXC9UPfCJozJGisA6dXLLClucOCPgHtkk
	MpU/IPL6kVxYpRj7u6OpE0TDEVYARu7v1R07VCbujX6K9OE43l6r
X-Received: by 2002:a05:6214:5015:b0:921:8d9:7f8e with SMTP id 6a1803df08f44-92134a6ded7mr155188986d6.12.1795358313858;
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm79665516d6.39.2026.11.22.06.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:33 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 09:38:29 -0500
Message-ID: <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122092235-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> this is followed by:
>
>                 virtio_features_zero(all_features);
>                 argp += sizeof(u64);
>                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
>                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
>                         return -EFAULT;
>
> copies at most 8 bytes.
>
>
> did you test that this patch actually helps anything?

That first copy is bounded, yes. The unbounded part is the loop right
after it, which is outside the diff context:

		for (i = copied; i < count; ++i) {
			if (copy_from_user(&features, featurep + 1 + i,
					   sizeof(features)))
				return -EFAULT;
			if (features)
				return -EOPNOTSUPP;
		}

It reads one u64 per iteration up to the count from user space. With
count = U64_MAX and a large zero-filled mapping, it only stops at the
first unreadable address.

Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
count = U64_MAX:

  1 GiB zero-filled mapping:
    without the patch: EFAULT after 27.4 s
    with the patch:    E2BIG at once

  2 GiB mapping, SIGKILL sent 1 s into the ioctl:
    without the patch: the process is reaped 46.7 s after the kill
    with the patch:    the ioctl has already returned

I have a small reproducer (a few lines of C). Since I found this with
the help of an LLM, Documentation/process/security-bugs.rst asks me to
treat it as public and not post the reproducer to a public list, so I
have not included it here. I am happy to send it to you off-list if it
would help.

Thanks,
Hengyu
