Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968663;
	b=GaqVxOEbc5PodwNsOILuN5WsF1vLaBQocSBe4bGUJC+7Vv4u6d0hLRBPfDydIzHirr7w
	 0Brgvr10EXxy4OAiiCNAT05xQTDGrPPe3fd93J5/JpszjFZLM9R3PlwQzzySorfXdQgLD
	 xx6x5x+q8NE7+iwcHOWv8n3VCVQ726vTGULxqRf0MJXeT7yH0vk4iSKAgWsUWu4ebvkT3
	 xkDMMi76IuxBKy3sFQc8h1HC8PxGLvqzWHjKpAJxK/cDTF+9tsRFKWkH8HZF4vxUPLufB
	 NJ3F47ezLlXzp634eBvduxFsPXFLyIC2LkUhXm/hpZt9f707JoGrgX5Wq55qjS+guXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968663;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iYuNhSenOI7lcfVk5lUHNYaSXsoThqyrOax2DqYfx4U=;
	b=eGu1PE6p0TpPe0GhGZyaChzIXhXVK6X0Pm13SzPuKKwZI1DYgMlG3q5TYkptrg3LI+EV
	 aK89zbYcTs8yIeS+Mlc91RTEfuHXKKMgsAlQsLxGcwfs2CPGHvQ2lojX3U8QSnSmOqoKu
	 Gn8hPPI2Iu0oY4vqBN6VziOX913rYORo92bpWfjMnORt0qFGo/eSxQ2ootrNo2ytc0Gpk
	 c62kTqffa5eS3qmz9NoJCsGmYIPrXXZXWoWR//Hk2uDotLJoS2oAjbGoJY/Lg/bc1O9sW
	 THMT2ajoYA34t7Z3qTXUe5JQCJO2Do4tiRhhFrG6gZSj/vvviN1y5pKEl06qeywzp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhypPOzb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A00606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhypPOzb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F81F0089F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968662;
	bh=iYuNhSenOI7lcfVk5lUHNYaSXsoThqyrOax2DqYfx4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DhypPOzbv1H82KnEwwcLrD4a9toQJKWpViEJOZgJ1ti0/XUGs6KYyu5QKayiEf4N8
	 tKAJq/SgoPfsB9B6Jxc9p4HH5+JqAWWDI4z/HLs9rQYwSR88Ft5gYazMUS9gEVSCao
	 1wsVTHtPLjS9zA8914weFTRqZG9wBilrod1nK6LKhDs6quISpZDbm27KY4ltkGwXuy
	 k4DhPWeHSKKxC6Vg/rcv8i3EpjUNmwnJEdctWKrGUy/BbCkW0TAuYLgwSO+MJRfnvY
	 Va50VPTZd+l6UJSgngy3/3IVq/upIMNg6+d8hw+K6a0YF4tUfaMKzC2uaMnjGDAWL3
	 mm21Xc/tpjv9w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c434376dbebso120130966b.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:37:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzCApXlFr+WBNuVgYzQTBFiEaOcJrbL05UpARDEU6jHJg0XnAKqRAnZ4FOmqmlL8zcZGgO+Wmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xXtAuO6+ltza9jOn3fvKH9HZpezNFZ8ua0riaxIFZn6Vr/p1U
	0aE6A3jE5EIFWFOO6sx7uQzd+pvHosNyIoIHc3dCs1DLP5yQFwKM1HVTzpJjwCJ/UdHetJo3B1t
	kPekfe2doEoEnoMQph5sCGZG2F/RdHdE=
X-Received: by 2002:a17:906:3617:b0:c46:7fa4:9212 with SMTP id
 a640c23a62f3a-c4d3556d0d9mr152301766b.23.1793968660997; Fri, 06 Nov 2026
 04:37:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106112752.2552832-1-wahidzk0091@gmail.com>
In-Reply-To: <20261106112752.2552832-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Nov 2026 21:37:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9LgeNhDYKedSXQzY+SDd5OMxS-8O6kKt0zxriH+V5KLA@mail.gmail.com>
X-Gm-Features: AclHuK-xYyx6CFwKY7XxaKKWjDV7an6HvC6v7wSiuOAXrjNZzfiOfSvNhgcD2Ps
Message-ID: <CAKYAXd9LgeNhDYKedSXQzY+SDd5OMxS-8O6kKt0zxriH+V5KLA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: check the file name against the key length of an
 index entry
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:28=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> w=
rote:
>
> ntfs_index_entry_inconsistent() checks that the file name of a
> $FILE_NAME key fits in the index entry. It does not check that the name
> fits in the key, which is what key_length describes. Code that works on
> the key alone relies on that.
>
> ntfs_readdir() copies key_length bytes of the key of the next entry to
> resume the enumeration, and later uses the copy to search the index. If
> file_name_length is larger than the key holds, the name comparison reads
> past the copy:
>
>   BUG: KASAN: slab-out-of-bounds in ntfs_file_compare_values+0x2d1/0x4b0
>   Read of size 2 at addr ffff88800a4ef2ce by task init/1
>    ntfs_file_compare_values
>    ntfs_collate
>    ntfs_ie_lookup
>    ntfs_index_lookup
>    ntfs_readdir
>    iterate_dir
>   Allocated by task 1:
>    kmemdup_noprof
>    ntfs_readdir
>   The buggy address is located 0 bytes to the right of
>   allocated 78-byte region
>
> Two bytes of an image from mkntfs are enough: in an entry whose name has
> six characters (key_length 78), change file_name_length from 6 to 7, so
> the key claims 80 bytes. The entry itself is 96 bytes, so the existing
> check lets it pass. The next readdir of the directory reads the extra
> bytes.
>
> Check the name against key_length, and check that the key is large
> enough to hold file_name_length in the first place.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
Applied it to #ntfs-next.
Thanks!
