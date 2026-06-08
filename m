Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4E3D5676
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=64.215.233.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939049; cv=fail; b=VwVWmAW/ljhCUqWP2qlFm2QPsO/77WDO6jXRwWmYRqaqUyDrEsrd9qSdLp9vb1pGhTDLonQACgvgdUwWPcwhw+Fgy6wjwf//AkyQVAwZB4msSYmlhXknJwrBVdIJnK7tjGft+JCNwfkBxPSHuab9Zt2CAopKFKQGTbH3OiTDrCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939049; c=relaxed/simple;
	bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/9vA/zXTGihIJdfOvo7JiJFYWeU/w5SA2mfesijg+1ebBvOYjl9n14Zmb5ZCTSqak81qHPtZEb2xV+82vjgJpwwVVSl+Zubw0ny+I+tzBqOiEKb06L7m9ZmLNXVwslK0rGus8rA8TeVbbyzN+sq2AvvFVKkbrhWl/SpRXSRJwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=XXcB22Lt; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=iEF9RcsS; arc=fail smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="XXcB22Lt";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="iEF9RcsS"
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.99.4)
 	id 1wWdbG-00000006QtR-2jGj
 	for stable@vger.kernel.org;
 	Mon, 08 Jun 2026 13:17:22 -0400
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bed31c8fd55so202228366b.1
         for <stable@vger.kernel.org>; Mon, 08 Jun 2026 10:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939042; cv=none;
         d=google.com; s=arc-20240605;
         b=jpiBBBT4AlGB8dmuXyGV+rlD+jW/XkZj7igeJMIOKT02Tjqe+hSFtVjgxqWUH5zQZ0
          cw1LWuulRK0gjaJXm/O97BZBzjrR1KaDhMIvPiB2v8iXE3vzURPF5cv6IohQ4pplS8ft
          cwhYhXownmghLxbFRoUMk18SZwTx34MEOJ+DkDblWrmNx6XqmRgLYBpKsb6MA/8ug3pc
          Zmq3QCuFBOJuLJtSM/Qpd6k6t2B9CIl3nQOROGituQ9uooRfOGOe6OC/I25MFPvyck5W
          albYwXFP7a33K5kphqI3gvXXawx9YxbHH6jjb+gE9Bht3vIBVa4oYq7DRFcJK4b/lzdX
          pYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:dkim-signature;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         fh=CInYFKE23kTlPD+qMDr0p1mqmsT3IBclxFhCkP2aGTw=;
         b=G+CjEqBBKvNqQVrtyFodike76kHFa9NoidOldnDWSTZxD1HjcAFPIxvxC9/tfbh4y9
          5fAwJs8tcWn8HzwLAkmOuKMRYhfWB9RjTzIMkvrksdULr2jx3RdmXEkt7HvEiSNkUL54
          RS8TbwWJmMXXWvqj9bCatoI3U8tbJ3PSLVs82dKSEuMDGH4eBMBeWACVQt3EhidBIRYe
          gKouWljz3hw3Ur8R+4ity+xpgNeEZSWzhj/Q3IjT+idIjs4VZxvm3/wtAqa9C1FztPgX
          dvqBFEm1yYEHjGhE/etRGmxbyPv4MKx+X1P2ofZOVGckSr3RoKZOL9sHzJqaAK71ryR7
          pPzA==;
         darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1780939042; x=1781543842; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         b=XXcB22LtEBzsh1FnSTtwXA4PQX97VVdzgkwsMoenOMe8iiJeoX4Tz9ZqARwvw3ExsE
          x22P18IubQK8L+O6WHC/36u+ayUgmmPluBmeFKmwrwDQE0TPVbMEe+TiHpfANPJTKgSG
          nJT78VuOl+/Ahv4bNHmatz+RdxhySgBInpZwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1780939042;
  bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=iEF9RcsSVUznVNnTsCCypCI0GGTTr0aqGDIQelANpcqz1YD1dMTzOqyHe8Tc/1SZb
  uuVnGMN6wLAIQAifDYRR7vKISMCtL56XmY+8Zy3q15ursCo+qXSD4WIrn4z2pht1+2
  keSAGpV1H2z7C5233YiaePDrJ0DGUA16NZrlPj8KqQjcjyaCpwVzzSCVkgrR0Qh8qG
  AMzCv0vJ8sBkzyRjAl/1xt1d4XKoyYF5AqISfRz7ma2kkHezI/bOYZs3hSgGCfDoba
  6Bip2Kvp2DZOfFhylOnHdSQ+V8eHfwCpy55DFOe51Ci6aAlghHh6ANWQtX/WiST9vK
  +z3enW0HS6dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20251104; t=1780939042; x=1781543842;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
          :to:cc:subject:date:message-id:reply-to;
         bh=nviWi2SVvs6kP8+AcZcCp02bcOI3+H6tiI/C6wy+oDU=;
         b=Yb5+abhjzyKgyrugdK2RRWQQAobr0JLf8xF1ObORxbRxH90XnTrMucIPju09oTDpvI
          0yYSknIpL+wozAe3u12AhLyZgABfZ/Z1Zm75fTaKpnWL7za70Sl2VHa5CxrWxl+QMR1f
          8BD7iyfpRZS2lndx9+vq/OAQVFbDR5DgHwfmfYztfcXszfPBIY5BNp5878JsTioSJAKX
          KdgIMNuWfDnUvdTqyEHw4Kl8HusgCdruBv+S+nk2jJLdnrO5tOP6Y33c7aytPGXhT8RX
          FVg8qZ/aMDMMDeYN9VyCUyZtsNwsC5zndpLFDTDZTsPh97xcwqJG8RtQQp4k9+Pdnh4V
          UCAg==
X-Forwarded-Encrypted: i=1; AFNElJ/osOecaRfuKaypLWbwAr9LwZ8MrZnw0rteXjKcm4thQQ5AjGo07xmOwpUVxmfZgQS9DDTjuaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMn/pmOipD9sJFVoLTxja3r6qtufQqEeoXTZ7akLKhxnLvFtB+
 	BInosoD5p5hl5t2NYie/iqfuWljX5iCSzKrS30ZJbJtY7Y2vZ9vLqTN1LO5zZKb07MwfXnuIYFn
 	Vu79MUjofVUX3zlDRGeWnGvVqZa7IXF67QL0zsPKxSzBfGzlXjLTAdyWQWOL+22A2TbWdIJElYg
 	CKT4KlLV4SSrqj+jxVq8DRa/pau5K597M=
X-Gm-Gg: Acq92OEYwgzWa6tM6r8tUnTzO9hyr1kDh+YRKRBDTI9trt4QYKQtoTEMluVgRxtXRwR
 	4/w+5IahFwRDiRdHuM2DEw2yG5flHotmK4v6+V7m5oQd7Ouq1qlp7+UF2C5kzufkHL6QccyUE6R
 	gBklIAg2fewKMBijuIynsQPSGcj9eVgRKwjo4ynrr1+BeBxl31MxmmlsRLfFGw94uRxK93HTXlE
 	7GNicIe+HUqPiBP
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id a640c23a62f3a-bf3737ed359mr795417066b.43.1780939041650;
         Mon, 08 Jun 2026 10:17:21 -0700 (PDT)
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id
  a640c23a62f3a-bf3737ed359mr795415166b.43.1780939041283; Mon, 08 Jun 2026
  10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFN_u7FrgM4Dzie2jjkLwWV8P0dvUG_Wwy3Q9B3-2HnnWiDu8w@mail.gmail.com>
  <aiLxe-9Sub8cI3Py@bfoster> <aibns0xP6IVVNWh3@bfoster>
In-Reply-To: <aibns0xP6IVVNWh3@bfoster>
From: Eric Hagberg <ehagberg@janestreet.com>
Date: Mon, 8 Jun 2026 13:17:10 -0400
X-Gm-Features: AVVi8CcZJIKOxJFnY3us1cFaahXNeQdHGkpT9n3Gwe9O5wCWWT-jbuC6519peWk
Message-ID: <CAAH4uRB+Bh9UEVEW8Sb2yM4YhB-Q5UJ6KJJXari3DDF3n3S+-g@mail.gmail.com>
Subject: Re: [BUG] iomap/io_uring: O_APPEND async buffered write silently
  re-appends a data chunk (corruption) on XFS, 6.1.y/6.12.y
To: Brian Foster <bfoster@redhat.com>
Cc: Gregg Leventhal <gleventhal@janestreet.com>, hch@infradead.org, djwong@kernel.org, 
 	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:03=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
> Another idea that came to mind is to try and just replace the -EAGAIN
> return sequence from the low level iterator with a flag that triggers
> -EAGAIN from the next iter advance. The idea here is to allow the write
> to return partial completion (i.e. so no iov_iter revert) without having
> to return an error from the lowest level in the stack. I had claude come
> up with a quick patch [1] for reference/experimentation.
>
> This is based on v6.12 stable and compile tested only. It needs more
> review and testing in general but might be worth throwing your
> reproducer at if you can..?

With that patch applied, the reproducer runs clean - no errors - and
gets roughly the same performance (maybe slightly better) as when run
against a 6.18 kernel on the same VM.

Thanks,
-Eric
